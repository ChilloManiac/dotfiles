return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    enabled = false,
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Oil" },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    cmd = {
      "Neotree"
    },
    keys = {
      { "-", "<cmd>Neotree toggle current reveal<CR>", desc = "Neotree" },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ["G"] = function(state)
              local node = state.tree:get_node()
              if node.type == "directory" then
                vim.cmd("Telescope live_grep cwd=" .. node.path)
              elseif node.type == "file" then
                local path = node:get_parent_id();
                vim.cmd("Telescope live_grep cwd=" .. path)
              else
                vim.notify("Unsupported type " .. node.type)
              end
            end
          }
        }
      }
    }
  }

}
