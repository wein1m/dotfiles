---Try to require the module, but do not throw error when one of them cannot be
---loaded. Without this, any error in one config file would result in the
---remaining config files not being loaded.
---@param module string
local function safeRequire(module)
  ---@type boolean, string
  local success, errmsg = pcall(require, module)
  if not success then
    local msg = ("Error loading `%s`: %s"):format(module, errmsg)
    vim.schedule(function() vim.notify(msg, vim.log.levels.ERROR) end)
  end
end

safeRequire("config.lazy")
safeRequire("config.keymaps")
safeRequire("config.options")
safeRequire("funcs/session")
