local M = {
  'vinnymeller/swagger-preview.nvim',
  cmd = {
    "SwaggerPreview",
    "SwaggerPreviewStop",
    "SwaggerPreviewToggle"
  },
  config = function()
    require("swagger-preview").setup({
      -- The port to run the preview server on
      port = 8000,
      -- The host to run the preview server on
      host = "localhost",
    })
  end
}

return M
