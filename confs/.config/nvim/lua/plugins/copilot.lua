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
    opts = {
      -- model = "claude-3.7-sonnet-thought",
      prompts = {
        GithubPR = {
          prompt = [[
Create a PR description for the differences between main and HEAD. The first line should be a title, using a conventional commit style, such as 'feat: add new feature'.
The rest of the PR description should be a detailed explanation of the changes. Imagine the reader being well experienced in the codebase and quite busy so focus on the logical changes and the important changes that needs to be highlighted for a glance view. Low to no focus on how files have been moved around, or variables changed names.
Dont use any styling at all. Keep it as short as possible, but still informative.
          ]],
          context = "git:origin/main..HEAD"
        }
      },
      selection = function(source)
        local select = require("CopilotChat.select")
        return select.visual(source)
      end,
    },
    keys = {
      { '<leader>cc',  "<cmd>CopilotChatToggle<CR>",   desc = "Toggle Copilot Chat",     mode = { "v", "n" } },
      { '<leader>cr',  "<cmd>CopilotChatReview<CR>",   desc = "Toggle Copilot Review",   mode = "v" },
      { '<leader>cpr', "<cmd>CopilotChatGithubPR<CR>", desc = "Create a PR description", mode = "n" },
    }
  },
}

return M
