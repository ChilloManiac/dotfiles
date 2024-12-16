local multi_grep = function(opts)
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local make_entry = require('telescope.make_entry')
  local conf = require('telescope.config').values

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

local M = {
  "nvim-telescope/telescope.nvim",
  version = "0.1.x",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files hidden=true<cr>',        desc = "Find Files" },
    { '<leader>fg', '<cmd>Telescope git_files<cr>',                     desc = "Find Git Files" },
    { '<leader>gb', '<cmd>Telescope git_branches<cr>',                  desc = "Find Git Branches" },
    { '<leader>rg', multi_grep,                                         desc = "Grep" },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>',                     desc = "Find Help" },
    { '<leader>tr', '<cmd>Telescope resume<cr>',                        desc = "Telescope Resume" },
    { '<leader>fr', '<cmd>Telescope oldfiles<cr>',                      desc = "Find Recent files" },
    { '<leader>ve', '<cmd>Telescope find_files cwd=~/.config/nvim<CR>', desc = "Edit vim config" }
  },
  event = "VeryLazy" -- Need to load it for the ui-select
}



M.config = function()
  local telescope = require('telescope')
  local actions = require('telescope.actions')

  telescope.setup({
    defaults = {
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {}
      },
      ["fzf"] = {},
      ["dap"] = {},
    },
    pickers = {
      git_branches = {
        mappings = {
          i = { ["<cr>"] = actions.git_switch_branch }
        }
      }
    }
  })

  telescope.load_extension('ui-select')
  telescope.load_extension('fzf')
end

return M
