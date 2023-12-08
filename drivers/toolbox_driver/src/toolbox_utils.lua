local string_utils = require "string_utils"
local m = {}

--- @param device STDevice
function m.is_root(device)
  string_utils.starts_with(device.device_network_id, "root:")
end

--- @param device STDevice
function m.is_rest_client(device)
  string_utils.starts_with(device.device_network_id, "rest:")
end

return m
