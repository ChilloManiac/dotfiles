-- vim.pack.add({
--   "https://github.com/folke/snacks.nvim",
--   "https://github.com/coder/claudecode.nvim"
-- })

-- local claude = require("claudecode")

-- claude.setup({
--   terminal = {
--     provider = "none"
--   }
-- })


-- AI/Claude Code keymaps
-- vim.keymap.set("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
-- vim.keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
-- vim.keymap.set("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude" })
-- vim.keymap.set("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude" })
-- vim.keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add current buffer" })
-- vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send to Claude" })

-- Send line reference with comment to Claude tmux pane
local function send_comment(start_line, end_line)
  local filename = vim.fn.expand("%:p")

  -- Check exactly 2 panes in the window
  local pane_count = tonumber((vim.fn.system('tmux display-message -p "#{window_panes}"'):gsub("%s+", "")))
  if pane_count ~= 2 then
    vim.notify("Expected exactly 2 tmux panes, found " .. (pane_count or 0), vim.log.levels.WARN)
    return
  end

  -- Floating scratch buffer for comment input
  local buf = vim.api.nvim_create_buf(false, true)
  local width = 60
  local height = 8
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "cursor",
    row = 1,
    col = 0,
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
    title = " Comment ",
    title_pos = "center",
  })
  vim.bo[buf].buftype = "acwrite"
  vim.bo[buf].bufhidden = "wipe"
  vim.api.nvim_buf_set_name(buf, "claude-comment")
  vim.cmd("startinsert")

  local saved_comment = nil

  vim.keymap.set('i', '<CR><CR>', "<ESC>:wq<CR>", { buf = buf })


  -- :w captures content, marks clean so :q won't warn
  vim.api.nvim_create_autocmd("BufWriteCmd", {
    buffer = buf,
    callback = function()
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      saved_comment = vim.trim(table.concat(lines, " "))
      vim.bo[buf].modified = false
    end,
  })

  -- On close: submit saved content if non-empty
  vim.api.nvim_create_autocmd("WinClosed", {
    buffer = buf,
    once = true,
    callback = function()
      if not saved_comment or saved_comment == "" then return end

      local submit = saved_comment:match("^Submit!%s*$") ~= nil or saved_comment:match("%s+Submit!%s*$") ~= nil
      local comment = saved_comment:gsub("%s*Submit!%s*$", "")

      if comment == "" and submit then
        vim.fn.system('tmux send-keys -t "{last}" Enter')
        return
      end
      if comment == "" then return end

      local loc = start_line == end_line
          and string.format('@"%s#L%d"', filename, start_line)
          or string.format('@"%s#L%d-%d"', filename, start_line, end_line)
      local text = string.format('%s - %s', loc, comment)

      -- Escape special chars for tmux send-keys
      local escaped = text:gsub("\\", "\\\\"):gsub('"', '\\"'):gsub("`", "\\`"):gsub("%$", "\\$")
      vim.fn.system(string.format('tmux send-keys -t "{last}" -- "%s"', escaped))
      vim.fn.system('tmux send-keys -l -t "{last}" "\x1b\r"')
      if submit then
        vim.fn.system('tmux send-keys -t "{last}" Enter')
      end
    end,
  })
end

vim.keymap.set("v", "<leader>ac", function()
  local start_line = vim.fn.getpos("v")[2]
  local end_line = vim.fn.getpos(".")[2]
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "nx", false)
  send_comment(math.min(start_line, end_line), math.max(start_line, end_line))
end, { desc = "Comment on selection" })

vim.keymap.set("n", "<leader>ac", function()
  local line = vim.fn.line(".")
  send_comment(line, line)
end, { desc = "Comment on line" })

vim.keymap.set("n", "<leader>as", function()
  vim.fn.system('tmux send-keys -t "{last}" Enter')
end, { desc = "Submit to Claude" })

-- Diff management
-- vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff" })
-- vim.keymap.set("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff" })

-- Add file from file explorer (for specific filetypes)
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
--   callback = function()
--     vim.keymap.set("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", { desc = "Add file", buffer = true })
--   end,
-- })
