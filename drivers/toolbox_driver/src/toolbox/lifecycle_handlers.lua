local log = require "log"
local m = {}

--- @param driver ToolboxDriver
--- @param device ToolboxDevice
function m.added(driver, device)
  log.info("---------------------------------- Toolbox Root Device Added")
end

--- @param driver ToolboxDriver
--- @param device ToolboxDevice
function m.init(driver, device)
  log.info("---------------------------------- Toolbox Root Device Init")
  device:online()
end

--- @param driver ToolboxDriver
--- @param device ToolboxDevice
function m.removed(driver, device)
  log.info("---------------------------------- Toolbox Root Device Removed")
  driver.datastore.root_dni = nil
end

return m
