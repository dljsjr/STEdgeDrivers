local Driver = require "st.driver"

local log = require "log"
local socket = require "cosock.socket"

function disco(driver, _, should_continue)
  log.info('beginning discovery')
  if not driver.device_created and #driver:get_devices() == 0 then
    log.info("No placeholder device created yet, creating one")
    local msg = {
      type = "LAN",
      device_network_id = "1234",
      manufacturer = "Doug",
      model = "MysteryMeat",
      vendor_provided_label = "Useless",
      profile = 'bad-doconf',
      label = "Garbage"
    }
    driver:try_create_device(msg)
    driver.device_created = true
  end
  while should_continue() do
    socket.sleep(0.2)
  end
  log.info('ending discovery')
end

function bad_configure(_, _)
  error("Guess I'll Die :(", 42)
end

local driver = Driver("Bad DoConfigure Driver", {
  discovery = disco,
  device_created = false,
  lifecycle_handlers = {
    doConfigure = bad_configure
  }
})

driver:run()
