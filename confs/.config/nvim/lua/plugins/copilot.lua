local M = {
  {
    "zbirenbaum/copilot.lua",
    dependencies = {},
    event = { "InsertEnter" },
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
        markdown = true,
        yaml = true,
      }
    }
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {},
    keys = {
      { '<leader>cc', "<cmd>CopilotChatToggle<CR>", desc = "Toggle Copilot Chat",   mode = { "v", "n" } },
      { '<leader>cr', "<cmd>CopilotChatReview<CR>", desc = "Toggle Copilot Review", mode = "v" },
    }
  },
}

return M
