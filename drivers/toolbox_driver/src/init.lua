local log = require "log"
local socket = require "cosock.socket"

local Driver = require "st.driver"
local mdns = require "st.mdns"
local st_utils = require "st.utils"

local lifecycle_handlers = require "lifecycle_handlers"

local capabilities = require "st.capabilities"
local createToolId = "absolutedegree01276.createRestClient"
local createRestClientCap = capabilities[createToolId]

--- @param driver ToolboxDriver
--- @param opts table
--- @param should_continue function
function disco(driver, opts, should_continue)
  log.info('beginning discovery for Toolbox')

  local create_attempted = false

  while should_continue() do
    local known_devices = driver:get_devices()

    if #known_devices == 0 and not create_attempted then
      local dni = "root:" .. st_utils.generate_uuid_v4()
      driver.datastore.root_dni = dni
      local create_device_msg = {
        type = "LAN",
        device_network_id = dni,
        label = "LAN Toolbox",
        profile = "toolbox",
        manufacturer = "Doug Stephen",
        model = "LAN-TOOLBOX-ROOT",
        vendor_provided_label = "LanToolboxRootDevice",
      }

      log.trace("Emitting device create")
      driver:try_create_device(create_device_msg)
      create_attempted = true
    end

    socket.sleep(1)
    print('sleep end')
  end
  log.info('ending discovery for Toolbox')
end

local driver = Driver("Toolbox Driver", {
  discovery = disco,
  lifecycle_handlers = lifecycle_handlers,
  capability_handlers = {
    [createRestClientCap.ID] = {
      [createRestClientCap.commands.newRestClient.NAME] = function (driver, device)
        log.info("------------ PUSHED THE CREATE BUTTON")
      end
    }
  }
})

driver:run()
