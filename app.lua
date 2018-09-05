--    Filename:     app.lua
--    Description:  mqtt data handlers
--    Version:      1.0.0(2018/9/5 16:45:04)
--    Author:       Pan Lin <740502708@qq.com>

local sensorData = {}

sensorData["serNum"] = config.ID
sensorData["batVol"] = 0
sensorData["sgnStr"] = 0
sensorData["devLoc"] = config.ADDR
sensorData["msgTime"] = ""
sensorData["tprInt"] = 0
sensorData["tprDec"] = 0


local function genRandom()
    math.randomseed(tmr.now())
    sensorData["batVol"] = (math.random(50)/100 + 4.75)
    sensorData["sgnStr"] = (math.random(10) + 60)
    math.randomseed(tmr.now())
    sensorData["tprInt"] = (math.random(6) + 22)
    sensorData["tprDec"] = math.random(9)
end

local function genSendData()
    genRandom()
    sensorData["msgTime"] = getCurTime()
    return string.format(
        "%s,%4.2f,%d,%s,%s,%d,%d", 
        sensorData["serNum"], 
        sensorData["batVol"], 
        sensorData["sgnStr"], 
        sensorData["devLoc"], 
        sensorData["msgTime"] , 
        sensorData["tprInt"], 
        sensorData["tprDec"]
        ) 
end


local function _mqttPub(sendData)
    m = mqtt.Client(config.ID, 60)
    m:connect(config.HOST, config.PORT, 0, function(client)
        print("connected")
        client:publish(config.TOPIC, sendData, 0, 0, function(client) print("pressure value published")  end)
    end,
    function(client, reason)
        print("failed reason: " .. reason)
    end)
    m:close()
end

function mqttPub()
    gpio.write(0, gpio.LOW)
    sendData = genSendData()
    print ("------data-------")
    print (sendData)
    print ("-----------------")
    _mqttPub(sendData)
    gpio.write(0, gpio.HIGH)
end




