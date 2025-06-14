local M = {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  enabled = false,
  lazy = false,
  keys = {
    {
      "<leader>pp",
      ":Noice dismiss<CR>",
      desc = "Dismiss"
    },
    {
      "<leader>pe",
      ":Noice enable<CR>",
      desc = "Enable"
    },
    {
      "<leader>pd",
      ":Noice disable<CR>",
      desc = "Disable"
    },
  },
}

M.config = function()
  local noice = require("noice")

  noice.setup({
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    messages = {
      enabled = true
    },
    notify = {
      enabled = true
    },

    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true,         -- use a classic bottom cmdline for search
      command_palette = true,       -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false,           -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false,       -- add a border to hover docs and signature help
    },
  })
end

return M
