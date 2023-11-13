return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  keys = {
    { '<leader>xx', function() require('trouble').toggle() end,                        desc = "Trouble Toggle" },
    { '<leader>xw', function() require('trouble').toggle('workspace_diagnostics') end, desc = "Trouble Toggle Workspace" },
    { '<leader>xd', function() require('trouble').toggle('document_diagnostics') end,  desc = "Trouble Toggle Document" },
    { '<leader>xq', function() require('trouble').toggle('quickfix') end,              desc = "Trouble Toggle Quickfix" },
    { '<leader>xl', function() require('trouble').toggle('loclist') end,               desc = "Trouble Toggle Loclist" },
    { '<leader>xr', function() require('trouble').toggle('lsp_references') end,        desc = "Trouble Toggle LSP References" },
  }
}
