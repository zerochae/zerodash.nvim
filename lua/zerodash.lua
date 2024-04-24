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

  return buttons
end

local function open(header)
  return function()
    vim.g.nv_previous_buf = vim.api.nvim_get_current_buf()

    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_get_current_win()

    vim.api.nvim_win_set_buf(win, buf)

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, header)
  end
end

function Zerodash:new(opts)
  local header_text = gray_nvim_calvin
  local zerodash = setmetatable({}, Zerodash)

  zerodash.opts = opts
  zerodash.header = get_header(header_text)
  zerodash.buttons = get_buttons()
  zerodash.open = open(header_text)

  return zerodash
end

function Zerodash:setup(opts)
  local zerodash = Zerodash:new(opts)
  zerodash.open()
end

return Zerodash
