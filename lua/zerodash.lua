local U = require "util"

local default_opts = {
  header = {},
  buttons = {},
  highlight = {
    header = {
      fg = "#519fdf",
      bg = "none",
    },

    buttons = {
      fg = "#8fc6f4",
      bg = "none",
    },
  },
}

local Zerodash = {}

local function get_header(opts)
  local has_cmd = U.has_cmd(opts.header_cmd)
  local cmd_executable = has_cmd and U.is_executable(opts.header_cmd[1])

  if cmd_executable then
    local cmd = U.make_cmd(opts.header_cmd)
    local header = vim.fn.systemlist(cmd)
    return header
  end

  if opts.header.length ~= 0 then
    return opts.header
  end

  return {}
end

function Zerodash:set_opts()
  vim.opt_local.filetype = "zerodash"
end

function Zerodash:set_buf()
  local buf = vim.api.nvim_create_buf(false, true)

  self.buf = buf
end

function Zerodash:set_win()
  local win = vim.api.nvim_get_current_win()

  self.win = win
end

function Zerodash:set_header(header)
  local emmptyLine = string.rep(" ", vim.fn.strwidth(header[1]))
  table.insert(header, 1, emmptyLine)
  table.insert(header, 2, emmptyLine)
  table.insert(header, emmptyLine)
  table.insert(header, emmptyLine)

  self.header = header
end

function Zerodash:set_buttons(buttons)
  self.buttons = buttons or {}
end

function Zerodash:set_width()
  local width = #self.header[1] + 3

  self.width = width
end

function Zerodash:set_max_height()
  local max_height = #self.header + 4 + (2 * #self.buttons)

  self.max_height = max_height
end

function Zerodash:set_highlight(highlight)
  local hi_header = highlight.header
  local hi_buttons = highlight.buttons

  vim.cmd("hi ZerodashHeader guifg=" .. hi_header.fg .. " guibg=" .. hi_header.bg)
  vim.cmd("hi ZerodashButtons guifg=" .. hi_buttons.fg .. " guibg=" .. hi_buttons.bg)
end

function Zerodash:set_result()
  local result = {}
  local dashboard = {}
  local max_height = math.max(vim.api.nvim_win_get_height(self.win), self.max_height)

  for i = 1, max_height do
    result[i] = ""
  end

  for _, val in ipairs(self.header) do
    table.insert(dashboard, val .. " ")
  end

  for _, val in ipairs(self.buttons) do
    table.insert(dashboard, U.btn_padding(val[1], val[2], self.header[1]) .. " ")
    table.insert(dashboard, self.header[1] .. " ")
  end

  local start_index = U.get_start_index(dashboard, self.win)

  for _, val in ipairs(dashboard) do
    result[start_index] = U.add_padding(self.win, val)
    start_index = start_index + 1
  end

  self.dashboard = dashboard
  self.result = result
end

function Zerodash:print()
  vim.api.nvim_win_set_buf(self.win, self.buf)
  vim.api.nvim_buf_set_lines(self.buf, 0, -1, false, self.result)

  local abc = math.abs(math.floor((vim.api.nvim_win_get_height(self.win) / 2) - (#self.dashboard / 2))) + 1
  local zerodash = vim.api.nvim_create_namespace "zerodash"
  local horiz_pad_index = math.floor((vim.api.nvim_win_get_width(self.win) / 2) - (self.width / 2)) - 2

  for i = abc, abc + #self.header do
    vim.api.nvim_buf_add_highlight(self.buf, zerodash, "ZerodashHeader", i, horiz_pad_index, -1)
  end

  for i = abc + #self.header - 2, abc + #self.result do
    vim.api.nvim_buf_add_highlight(self.buf, zerodash, "ZerodashButtons", i, horiz_pad_index, -1)
  end

  vim.api.nvim_win_set_cursor(self.win, { abc + #self.header, math.floor(vim.o.columns / 2) - 13 })
end

function Zerodash:new(opts)
  local zerodash = setmetatable(opts, self)
  self.__index = self

  return zerodash
end

function Zerodash.setup(opts)
  opts = U.merge_tables(default_opts, opts)

  local header = get_header(opts)
  local zerodash = Zerodash:new(opts)

  zerodash:set_buf()
  zerodash:set_win()
  zerodash:set_header(header)
  zerodash:set_buttons(opts.buttons)
  zerodash:set_width()
  zerodash:set_max_height()
  zerodash:set_result()
  zerodash:set_highlight(opts.highlight)
  zerodash:set_opts()

  zerodash:print()
end

return Zerodash
