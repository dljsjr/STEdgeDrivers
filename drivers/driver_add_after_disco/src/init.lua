local Driver = require "st.driver"

local log = require "log"
local socket = require "cosock.socket"
local generate_uuid = require "st.utils".generate_uuid_v4

--- @param driver Driver
--- @param opts table
--- @param should_continue function
function disco(driver, opts, should_continue)
  log.info('beginning discovery')
  while should_continue() do
    socket.sleep(0.2)
  end
  log.info('ending discovery, creating a new device')

  local num_devices = #driver:get_devices()
  local create_device_msg = {
    type = "LAN",
    device_network_id = generate_uuid(),
    label = "Late Added Device No. " .. (num_devices + 1),
    profile = "add-after-disco",
    manufacturer = "Aperture Science, INC",
    model = "867-5309",
    vendor_provided_label = "AddAfterDiscoDevice",
  }

  driver:try_create_device(create_device_msg)
end

local driver = Driver("Add After Disco Driver", {
  discovery = disco
})

driver:run()
