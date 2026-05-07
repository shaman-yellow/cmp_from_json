
local cmp = require('cmp')
local source_mod = require('cmp_from_json.source')

local instance = source_mod.new()

cmp.register_source('cmp_from_json', instance)

return instance

