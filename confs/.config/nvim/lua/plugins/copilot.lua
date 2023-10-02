local M = {
  "zbirenbaum/copilot.lua",
  dependencies = {
     -- { "zbirenbaum/copilot-cmp" },
  },
  event = { 'InsertEnter' },
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

}

return M
