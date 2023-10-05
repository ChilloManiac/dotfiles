local resetSoft = function()
  local merge_base = vim.fn.system('git merge-base --fork-point origin/main')
  vim.cmd('Git reset --soft ' .. merge_base)
end

local newBranch = function()
  vim.ui.input({ prompt = "Branch name: " }, function(newBranchName)
    if newBranchName ~= nil then
      vim.cmd('Git switch -c ' .. newBranchName)
    end
  end)
end

local stashAndNewBranch = function()
  vim.cmd('Git add -A')
  vim.cmd('Git stash')

  newBranch()

  vim.cmd('Git stash pop')
end

local M = {
  "tpope/vim-fugitive",
  keys = {
    { '<leader>gf',  "<cmd>diffget //3<CR>", desc = "Get right" },
    { '<leader>gj',  "<cmd>diffget //2<CR>", desc = "Get left" },
    { '<leader>gs',  "<cmd>Git<CR>",         desc = "Git status" },
    { '<leader>gr',  resetSoft,              desc = "Reset soft" },
    { '<leader>gnb', newBranch,              desc = "New branch" },
    { '<leader>gsb', stashAndNewBranch,      desc = "Stash and new branch" },
    { '<leader>gp',  "<cmd>Git pull<CR>",    desc = "Git pull" },
  },
  cmd = "Git"
}



return M
