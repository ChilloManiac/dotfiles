vim.pack.add({
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = "v3.x" },
  "https://github.com/nvim-lua/plenary.nvim",
  'https://github.com/nvim-tree/nvim-web-devicons',
  "https://github.com/MunifTanjim/nui.nvim",
})

vim.keymap.set("n", "-", "<cmd>Neotree toggle current reveal<CR>", { desc = "Neotree" })
require("neo-tree").setup({
  filesystem = {
    filtered_items = {
      hide_dotfiles = false
    },
    window = {
      mappings = {
        ["z"] = "noop",
        ["/"] = "noop",
        ["G"] = function(state)
          local node = state.tree:get_node()
          local path = nil
          if node.type == "directory" then
            path = node.path
          elseif node.type == "file" then
            path = node:get_parent_id();
          else
            vim.notify("Unsupported type " .. node.type)
          end
          if path ~= nil then
            _G.MiniPick.builtin.grep_live({}, { source = { cwd = path } })
          end
        end
      }
    }
  }
})
