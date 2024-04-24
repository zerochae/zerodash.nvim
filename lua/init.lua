local M = {}

local Zerodash = require "zerodash"

function M.setup(opts)
  local zerodash = Zerodash:new(opts)
  zerodash.open()
end

return M
