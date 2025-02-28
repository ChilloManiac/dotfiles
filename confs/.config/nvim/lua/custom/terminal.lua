local M = {}


M.state = {
  terminal = {
    buf = -1,
    win = -1,
  }
}

local create_window = function(opts)
  opts = opts or {}
  opts.buf = opts.buf or -1

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win = vim.api.nvim_open_win(buf, true, {
    split = "right",
    win = -1,
  })

  return { buf = buf, win = win }
end

M.toggle_term = function()
  if not vim.api.nvim_win_is_valid(M.state.terminal.win) then
    M.state.terminal = create_window({ buf = M.state.terminal.buf })
    if vim.bo[M.state.terminal.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(M.state.terminal.win)
  end
end

M.new_term = function()
  if vim.api.nvim_win_is_valid(M.state.terminal.win) then
    vim.api.nvim_win_close(M.state.terminal.win, true)
  end

  if vim.api.nvim_buf_is_valid(M.state.terminal.buf) then
    vim.api.nvim_buf_delete(M.state.terminal.buf, { force = true })
  end

  M.toggle_term()
end

return M
