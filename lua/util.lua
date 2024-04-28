local M = {}

M.add_padding = function(win, str)
  local pad = (vim.api.nvim_win_get_width(win) - vim.fn.strwidth(str)) / 2
  return string.rep(" ", math.floor(pad)) .. str .. " "
end

M.get_start_index = function(dashboard, win)
  local index = math.abs(math.floor((vim.api.nvim_win_get_height(win) / 2) - (#dashboard / 2))) + 1
  return index
end

M.btn_padding = function(txt1, txt2, header_text)
  local btn_len = vim.fn.strwidth(txt1) + vim.fn.strwidth(txt2)
  local spacing = vim.fn.strwidth(header_text) - btn_len
  return txt1 .. string.rep(" ", spacing - 1) .. txt2 .. " "
end

M.has_cmd = function(cmd)
  return cmd ~= nil
end

M.is_executable = function(module)
  return vim.fn.executable(module)
end

M.make_cmd = function(cmd_table)
  local cmd = table.concat(vim.tbl_flatten(cmd_table), " ")
  return cmd
end

return M
