local test = require "integration_test"
-- local test_utils = require "integration_test.utils"

local DEFAULT_DISCO_TIME = 10

test.add_package_capability("createRestClient.yml")

local function test_init()
end

test.register_coroutine_test(
  "Receiving a discovery event creates a toolbox root device",
  function()
    test.mock_devices_api.__expect_create_device({
      type = "LAN",
      deviceNetworkId = "root:d7168ace-64f6-4c87-3b19-e961b83292b9",
      label = "LAN Toolbox",
      profileReference = "toolbox",
      manufacturer = "Doug Stephen",
      model = "LAN-TOOLBOX-ROOT",
      vendorProvidedLabel = "LanToolboxRootDevice",
    })
    test.socket.discovery:__start_discovery_with_timeout(DEFAULT_DISCO_TIME)
    test.socket.discovery:__expect_discovery_ends(true)
    test.mock_time.advance_time(11)
    test.wait_for_events()
  end,
  {}
)

test.set_test_init_function(test_init)
test.run_registered_tests()
