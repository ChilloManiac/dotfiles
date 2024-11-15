local M = {
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      -- { "zbirenbaum/copilot-cmp" },
    },
    lazy = false,
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-CR>"
        }
      },
      panel = {
        enabled = true,
        auto_refresh = true,
        layout = {
          position = "right"
        }
      },
      filetypes = {
        TelescopePrompt = false,
        ["dap-repl"] = false,
      }
    }
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
    },
    lazy = false,
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = false,         -- Enable debugging
      -- See Configuration section for rest
    },
    keys = {
      { '<leader>cc', "<cmd>CopilotChatToggle<CR>", desc = "Toggle Copilot Chat" },
      { '<leader>cr', "<cmd>CopilotChatReview<CR>", desc = "Toggle Copilot Review", mode = "v" },
    }
    -- See Commands section for default commands if you want to lazy load on them
  },
}

return M
