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
      { "<leader>nn", "<cmd>tabnew<CR><cmd>Neorg workspace notes<CR>", "Open Neorg" },
    },
    config = function()
      local au_group = vim.api.nvim_create_augroup("Neorg", {})
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "norg",
        group = au_group,
        callback = function()
          vim.keymap.set("n", "<C-.>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", { buffer = true })
          vim.keymap.set("n", "nt", "<cmd>Neorg journal today<CR>", { buffer = true })
          vim.keymap.set("n", "ny", "<cmd>Neorg journal yesterday<CR>", { buffer = true })
          vim.keymap.set("n", "no", "<cmd>Neorg journal tomorrow<CR>", { buffer = true })
          vim.keymap.set("n", "nc", "<cmd>Neorg journal custom<CR>", { buffer = true })
          vim.keymap.set("n", "<leader>fn", "<cmd>Telescope find_files cwd=~/notes<CR>", { buffer = true })
        end
      })

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
          ["core.keybinds"] = {},
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
    end
  }
}
