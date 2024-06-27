return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true,   -- This automatically runs `require("luarocks-nvim").setup()`
  },
  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.integrations.treesitter"] = {},
          ["core.concealer"] = {},
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp"
            }
          },
          ["core.integrations.nvim-cmp"] = {},
          ["core.summary"] = {},
          ["core.ui"] = {},
          ["core.ui.calendar"] = {},
          ["core.esupports.metagen"] = {
            config = {
              type = "auto"
            }
          },
          ["core.keybinds"] = {
            config = {
              hook = function(keybinds)
                keybinds.remap_key("norg", "n", "<C-Space>", "<C-.>")
                keybinds.map("norg", "n", "mt", "<cmd>Neorg journal today<CR>")
                keybinds.map("norg", "n", "my", "<cmd>Neorg journal yesterday<CR>")
                keybinds.map("norg", "n", "mo", "<cmd>Neorg journal tomorrow<CR>")
                keybinds.map("norg", "n", "mc", "<cmd>Neorg journal custom<CR>")
              end,
            }
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
          ["core.dirman.utils"] = {},
          ["core.journal"] = {
            config = {
              workspace = "notes",
              strategy = "flat"
            },
          },
        }
      }

      vim.api.nvim_set_keymap("n", "<leader>mm", "<cmd>tabnew<CR><cmd>Neorg workspace notes<CR>",
        { noremap = true, silent = true })
    end
  }
}
