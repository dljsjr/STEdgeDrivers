local Driver = require "st.driver"

local log = require "log"
local socket = require "cosock.socket"

function disco(_, _, should_continue)
  log.info('beginning discovery')
  while should_continue() do
    socket.sleep(0.2)
  end
  log.info('ending discovery')
end

local driver = Driver("Empty LAN Driver", {
  discovery = disco
})

driver:run()
