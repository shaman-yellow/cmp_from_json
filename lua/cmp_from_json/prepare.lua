-- lua/cmp_from_json/prepare.lua
local M = {}
local cmp = require("cmp")
local core = require('cmp_from_json')

local function trigger_cmp()
  cmp.complete({
    config = {
      sources = {
        { name = 'cmp_from_json' }
      }
    }
  })
end

local event_registered = false

function M.on_data(json_str)
  json_str = json_str:gsub("@BS@", "\\")
  local items = vim.json.decode(json_str)

  local source = core.instance

  source:set_items(items)
  source:enable()
  trigger_cmp()

  if not event_registered then
    cmp.event:on('menu_closed', function()
      if source.active then
        vim.defer_fn(function()
          trigger_cmp()
        end, 100)
      end
    end)
    event_registered = true
  end

  vim.api.nvim_create_autocmd("InsertLeave", {
    once = true,
    callback = function()
      source:disable()
    end,
  })
end

return M

