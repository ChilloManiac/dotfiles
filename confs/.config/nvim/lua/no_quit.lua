local function im_not_a_quitter()
  vim.notify("I'm sorry, I can't let you do that, Dave.")
end


local quit_cmds = {
  "q", "qa", "wq", "wqa",
}

for _, cmd in ipairs(quit_cmds) do
  vim.keymap.set('ca', cmd, im_not_a_quitter, { noremap = true, silent = true })
end
