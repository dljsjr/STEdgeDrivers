local Driver = require "st.driver"

local log = require "log"
local socket = require "cosock.socket"
local ssl = require "cosock.ssl"
local st_utils = require "st.utils"

local SSL_CONFIG = {
  mode = "client",
  protocol = "any",
  verify = "peer",
  options = "all",
  cafile="cert.pem"
}

--- @param ip string
--- @param port number
--- @return table
local function make_ssl_socket(ip, port)
  local sock = assert(socket.tcp())
  assert(sock:settimeout(10))
  assert(sock:connect(ip, port))
  assert(sock:setoption("keepalive", true))
  sock = assert(ssl.wrap(sock, SSL_CONFIG))
  assert(sock:dohandshake())
  return sock
end

function disco(_, _, should_continue)
  log.info('beginning discovery')
  local sock = make_ssl_socket("192.168.1.132", 3030)
  while should_continue() do
    local recv = assert(sock:receive())
    log.info(st_utils.stringify_table(recv, "Socket Receive", true))
    socket.sleep(1.0)
  end
  log.info('ending discovery')
end

local driver = Driver("REST Client Sandbox", {
  discovery = disco
})

driver:run()
