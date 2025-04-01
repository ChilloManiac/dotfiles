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
      model = "claude-3.7-sonnet-thought",
      prompts = {
        GithubPR = {
          prompt =
          "Create a PR description for the differences between main and HEAD. The first line should be a title, using a conventional commit style, such as 'feat: add new feature'. The rest of the PR description should be a detailed explanation of the changes. Focus on the logical changes, and not so much on how files have been moved around, or variables changed names",
          context = "git:main..HEAD"
        }
      }
    },
    keys = {
      { '<leader>cc',  "<cmd>CopilotChatToggle<CR>",   desc = "Toggle Copilot Chat",     mode = { "v", "n" } },
      { '<leader>cr',  "<cmd>CopilotChatReview<CR>",   desc = "Toggle Copilot Review",   mode = "v" },
      { '<leader>cpr', "<cmd>CopilotChatGithubPR<CR>", desc = "Create a PR description", mode = "n" },
    }
  },
}

return M
