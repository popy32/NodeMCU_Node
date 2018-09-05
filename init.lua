--    Filename:     init.lua
--    Description:  All settings initialization
--    Version:      1.0.0(2018/9/5 16:45:04)
--    Author:       Pan Lin <740502708@qq.com>

dofile("config.lua")
dofile("utils.lua")
dofile("network.lua")
dofile("app.lua")

-- initiate gpio of led
gpio.mode(0, gpio.OUTPUT)
gpio.write(0, gpio.HIGH)

-- initiate wifi network
networkInit()

-- circle send data per $(config.PERIOD) second
tmr.create():alarm(config.PERIOD, tmr.ALARM_AUTO, mqttPub)
