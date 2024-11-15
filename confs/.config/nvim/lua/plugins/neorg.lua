local notesDir = "~/notes"

return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true,   -- This automatically runs `require("luarocks-nvim").setup()`
  },
  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    keys = {
      { "<leader>mm", "<cmd>tabnew<CR><cmd>Neorg workspace notes<CR>",        "Open Neorg" },
      { "<leader>fn", "<cmd>Telescope find_files cwd=" .. notesDir .. "<CR>", "Find notes" },
    },
    config = function()
      local au_group = vim.api.nvim_create_augroup("Neorg", {})
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "norg",
        group = au_group,
        callback = function()
          vim.keymap.set("n", "<C-.>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", { buffer = true })
          vim.keymap.set("n", "mt", "<cmd>Neorg journal today<CR>", { buffer = true })
          vim.keymap.set("n", "my", "<cmd>Neorg journal yesterday<CR>", { buffer = true })
          vim.keymap.set("n", "mo", "<cmd>Neorg journal tomorrow<CR>", { buffer = true })
          vim.keymap.set("n", "mc", "<cmd>Neorg journal custom<CR>", { buffer = true })
          vim.keymap.set("n", "md", "<cmd>e " .. notesDir .. "/todo.norg<CR>", { buffer = true })
        end,
      })

      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.integrations.treesitter"] = {},
          ["core.concealer"] = {},
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.integrations.nvim-cmp"] = {},
          ["core.summary"] = {},
          ["core.ui"] = {},
          ["core.ui.calendar"] = {},
          ["core.esupports.metagen"] = {
            config = {
              type = "auto",
            },
          },
          ["core.keybinds"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = notesDir,
              },
            },
          },
          ["core.dirman.utils"] = {},
          ["core.journal"] = {
            config = {
              workspace = "notes",
              strategy = "flat",
            },
          },
        },
      })
    end,
  },
}
