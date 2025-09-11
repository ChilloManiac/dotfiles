vim.pack.add({
  "https://github.com/zbirenbaum/copilot.lua",
  "https://github.com/CopilotC-Nvim/CopilotChat.nvim",
  "https://github.com/nvim-lua/plenary.nvim"
})

require("copilot").setup({
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
})

require("CopilotChat").setup({
  model = "claude-3.7-sonnet-thought",
  selection = function(source)
    local select = require("CopilotChat.select")
    return select.visual(source)
  end,
})

vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat", })
vim.keymap.set("v", "<leader>cc", "<cmd>CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat", })
vim.keymap.set("v", "<leader>cr", "<cmd>CopilotChatReview<CR>", { desc = "Toggle Copilot Review" })

vim.api.nvim_create_autocmd('PackChanged', {
  desc = 'Build tiktoken for CopilotChat',
  group = vim.api.nvim_create_augroup('CopilotChatUpdateHandler', { clear = true }),
  callback = function(event)
    if event.data.kind == 'install' and event.data.spec.name == 'CopilotChat' then
      ---@diagnostic disable-next-line: param-type-mismatch
      local ok = pcall(vim.cmd, 'make tiktoken')
      if ok then
        vim.notify('Make tiktoken completed successfully!', vim.log.levels.INFO)
      else
        vim.notify('Make tiktoken failed', vim.log.levels.WARN)
      end
    end
  end,
})
