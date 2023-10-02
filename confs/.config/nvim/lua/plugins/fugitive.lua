local resetSoft = function()
  vim.fn.system('git reset --soft $(git merge-base --fork-point origin/main)')
end

local newBranch = function()
  vim.ui.input({ prompt = "Branch name: " }, function(newBranchName)
    if newBranchName ~= nil then
      vim.fn.system('git switch -c ' .. newBranchName)
    end
  end)
end

local M = {
  "tpope/vim-fugitive",
  keys = {
    { '<leader>gf',  "<cmd>diffget //3<CR>", desc = "Get right" },
    { '<leader>gj',  "<cmd>diffget //2<CR>", desc = "Get left" },
    { '<leader>gs',  "<cmd>Git<CR>",         desc = "Git status" },
    { '<leader>gr',  resetSoft,              desc = "Reset soft" },
    { '<leader>gnb', newBranch,              desc = "New branch" },
    { '<leader>gp',  "<cmd>Git pull<CR>",    desc = "Git pull" },
  },
  cmd = "Git"
}



return M
