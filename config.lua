--
-- Basic configuration
--
-- This should be the same for all my apps. Secrets are stored in secrets.lua
--
local module = {}

-- identify NodeMCU by chipid
local nodenames = {}
nodenames[11642057] = "terrace"
module.SELF = nodenames[node.chipid()]
if module.SELF == nil then
  module.SELF = node.chipid()
  print("FAILED TO IDENTIFY NODEMCU CHIP")
end

-- configure wifi
module.WIFI = {}
module.WIFI.ssid = "khw.devices"
module.WIFI.pwd = "neepmaka"

-- configure MQTT
module.MQTT = {}
module.MQTT.host = "egghead.khw.local"
module.MQTT.port = 1883
module.MQTT.endpoint = "/home-assistant/" .. module.SELF .. "/"

return module
