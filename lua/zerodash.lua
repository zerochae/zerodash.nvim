local Zerodash = {}

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
  table.insert(header, header_text)
  add_padding()

  return header
end

local function get_buttons()
  local buttons = {}
end

local function open()
  vim.g.nv_previous_buf = vim.api.nvim_get_current_buf()

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_get_current_win()

  vim.api.nvim_win_set_buf(win, buf)
end

function Zerodash:new(opts)
  local zerodash = setmetatable({}, Zerodash)
  local header_text = gray_nvim_calvin
  zerodash.opts = opts
  zerodash.header = get_header(header_text)
  zerodash.buttons = get_buttons()
  zerodash.open = open()

  return zerodash
end

return Zerodash
