local _M = {
  picker = function()
    local input = vim.fn.input("zoxide: ")

    local zoxide_result = vim.fn.systemlist("zoxide query -l " .. input)

    if #zoxide_result == 0 then
      print("No results found")
      return
    end

    vim.ui.select(zoxide_result, { title = "zoxide" }, function(selected)
      vim.fn.chdir(selected)
    end)
  end
}

return _M
