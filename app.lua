local module = {}

function module.start_pump()
  print "pump requested"
  --if(get_current_level() == 1) then
    print "PUMP STARTED"
    --gpio.write(PIN_PUMP, gpio.HIGH)
    G.mqtt.publish("sensor/motor", "1", 1)
    -- safety: shut down after 45s
    tmr.create():alarm(45 * 1000, tmr.ALARM_SINGLE, module.stop_pump)
  --end
end

-- stop the pump
function module.stop_pump()
  print "PUMP STOPPED"
  --gpio.write(PIN_PUMP, gpio.LOW)
  G.mqtt.publish("sensor/motor", "0", 1)
end

-- configure everything
local function setup()
  -- register to do something after start up
  -- G.mqtt.waitThen(function()
  -- end)

  -- start wifi and mqtt
  G.wifi.waitThen(G.mqtt.start)

  -- register for pump commands
  G.mqtt.subscribe("switch/water", function(data)
    if(data == "1") then
      module.start_pump()
      else
      module.stop_pump()
    end
  end)

  -- turn off the pump on startup
  module.stop_pump()
end

-- run the application
function module.start()
  setup()
end

return module