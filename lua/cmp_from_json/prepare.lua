-- lua/cmp_from_json/prepare.lua
local M = {}

local core = require('cmp_from_json')

function M.on_data(json_str)
  json_str = json_str:gsub("@BS@", "\\")
  local items = vim.json.decode(json_str)

  core:enable()
  core:set_items(items)
  core:trigger()

end

return M

