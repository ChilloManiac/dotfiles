local resetSoft = function()
  local merge_base = vim.fn.system("git merge-base --fork-point origin/main")
  vim.cmd("Git reset --soft " .. merge_base)
end

local newBranch = function()
  vim.ui.input({ prompt = "Branch name: " }, function(newBranchName)
    if newBranchName ~= nil then
      vim.cmd("Git switch -c " .. newBranchName)
    end
  end)
end

local stashAndNewBranch = function()
  vim.cmd("Git add -A")
  vim.cmd("Git stash")

  vim.cmd("Git switch main")
  vim.cmd("Git pull")

  newBranch()

  vim.cmd("Git stash pop")
end

return {
  {
    "tpope/vim-fugitive",
    dependencies = {
      "sindrets/diffview.nvim",
      keys = {
        { "<leader>dvo", "<cmd>DiffviewOpen<CR>",  desc = "Diffview Open" },
        { "<leader>dvc", "<cmd>DiffviewClose<CR>", desc = "Diffview Close" }
      },
    },
    keys = {
      { "<leader>gs",  "<cmd>Git<CR>",      desc = "Git status" },
      { "<leader>gr",  resetSoft,           desc = "Reset soft" },
      { "<leader>gnb", newBranch,           desc = "New branch" },
      { "<leader>gsb", stashAndNewBranch,   desc = "Stash and new branch" },
      { "<leader>gp",  "<cmd>Git pull<CR>", desc = "Git pull" },
    },
    cmd = "Git",
    config = function()
      require("diffview").setup()

      -- Inspired by: https://github.com/sindrets/dotfiles/blob/d9cd3a1f1ad48c4c4ac26320a238df103bfcaded/.config/nvim/lua/user/plugins/fugitive.lua

      local augroup = vim.api.nvim_create_augroup("diffview-fugitive", {})

      local function get_sid()
        local script_entry =
            vim.api.nvim_exec2("filter #vim-fugitive/autoload/fugitive.vim# scriptnames", { output = true })

        local digits = string.match(script_entry.output, "%d+")
        return tonumber(digits)
      end

      local function get_info_under_cursor()
        if vim.bo.ft ~= "fugitive" then
          return
        end

        local sid = get_sid()

        if sid then
          return vim.call("<SNR>" .. sid .. "_StageInfo", vim.api.nvim_win_get_cursor(0)[1])
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        pattern = "fugitive",
        callback = function(ctx)
          -- Open Diffview for the item under the cursor
          vim.keymap.set("n", "D", function()
            local info = get_info_under_cursor()

            if info then
              if #info.paths > 0 then
                vim.cmd(("DiffviewOpen --selected-file=%s"):format(vim.fn.fnameescape(info.paths[1])))
              elseif info.commit ~= "" then
                vim.cmd(("DiffviewOpen %s^!"):format(info.commit))
              end
            end
          end, { buffer = ctx.buf })
        end,
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
