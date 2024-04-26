local gray_nvim_calvin = {
  [[                                  ]],
  [[    ┌─┐┬─┐┌─┐┬ ┬   ┌┐┌┬  ┬┬┌┬┐    ]],
  [[    │ ┬├┬┘├─┤└┬┘───│││└┐┌┘││││    ]],
  [[    └─┘┴└─┴ ┴ ┴    ┘└┘ └┘ ┴┴ ┴    ]],
  [[                                  ]],
}

local function get_header(header_text)
  local header = {}

  local function add_padding()
    local empty_string = string.rep(" ", vim.fn.strwidth(header_text[1]))

    table.insert(header, empty_string)
    table.insert(header, empty_string)
  end

  add_padding()
  for _, str in ipairs(header_text) do
    table.insert(header, str)
  end
  add_padding()

  return header
end

local function get_buttons()
  local buttons = {}

  return buttons
end

------------------------------------------ Zerodash ------------------------------------------

---@class Zerodash
---@field width integer
---@field opts any
---@field header table
---@field buttons any
---@field max_height any
local Zerodash = {}

function Zerodash:open()
  vim.g.nv_previous_buf = vim.api.nvim_get_current_buf()

  if self.width + 6 > vim.api.nvim_win_get_width(0) then
    vim.api.nvim_set_current_win(vim.api.nvim_list_wins()[2])
    self.win = vim.api.nvim_get_current_win()
  end

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_get_current_win()

  vim.api.nvim_win_set_buf(win, buf)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, self.header)
end

function Zerodash:new(opts)
  local header_text = gray_nvim_calvin
  local zerodash_instance = setmetatable(opts, self)
  self.__index = self

  zerodash_instance.header = get_header(header_text)
  zerodash_instance.buttons = get_buttons()
  zerodash_instance.width = #zerodash_instance.header[1] + 3
  zerodash_instance.max_height = #zerodash_instance.header + 4 + (2 * #zerodash_instance.buttons) -- 4  = extra spaces i.e top/bottom

  return zerodash_instance
end

function Zerodash:setup(opts)
  opts = opts or {}
  -- local zerodash = Zerodash:new(opts)
  -- zerodash:open()
end

return Zerodash
