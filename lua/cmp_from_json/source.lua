
local source = {}

function source.new()
  return setmetatable({
    items = {},
    active = false,
  }, { __index = source })
end

function source:set_items(items)
  self.items = items or {}
end

function source:enable()
  self.active = true
  vim.api.nvim_exec_autocmds("User", { pattern = "CmpFromJsonReady" })
end

function source:disable()
  self.active = false
  vim.api.nvim_exec_autocmds("User", { pattern = "CmpFromJsonDisable" })
end

function source:is_available()
  return self.active
end

function source:complete(_, callback)
  callback({
    items = self.items,
  })
end

return source
