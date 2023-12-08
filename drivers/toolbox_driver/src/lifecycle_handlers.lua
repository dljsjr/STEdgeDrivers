local toolbox_handlers = require "toolbox.lifecycle_handlers"
local toolbox_utils = require "toolbox_utils"

local m = {}

--- @param driver ToolboxDriver
--- @param device STDevice
function m.added(driver, device)
  if toolbox_utils.is_root(device) then
    ---@cast device ToolboxDevice
    toolbox_handlers.added(driver, device)
  end
end

--- @param driver ToolboxDriver
--- @param device STDevice
function m.init(driver, device)
  if toolbox_utils.is_root(device) then
    ---@cast device ToolboxDevice
    toolbox_handlers.init(driver, device)
  end
end

--- @param driver ToolboxDriver
--- @param device STDevice
function m.removed(driver, device)
  if toolbox_utils.is_root(device) then
    ---@cast device ToolboxDevice
    toolbox_handlers.removed(driver, device)
  end
end

return m
