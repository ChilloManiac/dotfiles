vim.pack.add({
  "https://github.com/scalameta/nvim-metals",
})

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

local metals_config = function()
  local metals = require("metals")
  local metals_config = metals.bare_config()
  metals_config.init_options.statusBarProvider = "off"
  metals_config.on_attach = function(client, bufnr)

  end

  metals.setup_dap()

  return metals_config
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config())
  end,
  group = nvim_metals_group,
})
