return {
  "nvimtools/none-ls.nvim",
  event = { "VeryLazy" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- null_ls.builtins.diagnostics.tsc
        null_ls.builtins.diagnostics.terraform_validate,
        null_ls.builtins.diagnostics.staticcheck,
        -- null_ls.builtins.diagnostics.spectral.with({
        --   args = { "lint", "-f", "json", "-q", "$FILENAME" },
        --   method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        -- })
      },
    })
  end,
}
