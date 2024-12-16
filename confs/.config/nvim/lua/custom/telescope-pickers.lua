local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values

local filter_grep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()
  opts.hidden = opts.hidden or true

  local finder = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local pieces = vim.split(prompt, "  ")
      local args = { "rg" }
      if opts.hidden then
        table.insert(args, "--hidden")
      end
      if pieces[1] then
        table.insert(args, "-e")
        table.insert(args, pieces[1])
      end

      if pieces[2] then
        table.insert(args, "-g")
        table.insert(args, pieces[2])
      end

      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten({
        args,
        { "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        }
      })
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd
  })

  pickers.new(opts, {
    debounce = 100,
    prompt_title = "Filter Grep",
    finder = finder,
    previewer = conf.grep_previewer(opts),
    sorter = require("telescope.sorters").empty()
  }):find()
end

local zoxide = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()
  local finder = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local args = { "zoxide", "query", "-l", prompt }

      return args
    end,
    entry_maker = make_entry.gen_from_string(),
    cwd = opts.cwd
  })

  local cd_to = function(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    actions.close(prompt_bufnr)
    if not selection then
      return
    end
    vim.fn.chdir(selection.value)
  end

  pickers.new(opts, {
    debounce = 100,
    prompt_title = "zoxide",
    finder = finder,
    previewer = nil,
    sorter = require("telescope.sorters").empty(),
    attach_mappings = function(_, map)
      map('i', '<CR>', cd_to)
      map('n', '<CR>', cd_to)
      return true
    end
  }):find()
end

return {
  filter_grep = filter_grep,
  zoxide_cd = zoxide
}
