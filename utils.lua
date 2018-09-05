
-- Lua implement string.split
-- Refer to https://stackoverflow.com/a/7615129
local function mysplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

-- Without ntp or extern rtc module
-- We also can get current time from HTTP response header
-- Like "29 Aug 2018 08:24:59"
local function _getCurTime()
    conn = net.createConnection(net.TCP, 0) 
    conn:on("connection",function(conn, payload)
    conn:send("HEAD / HTTP/1.1\r\n\r\n\r\n") 
                    end)
    conn:on("receive", function(conn, payload)
        _res = string.sub(payload, string.find(payload,"Date: ") + 11, string.find(payload,"Date: ")+31)
        conn:close()
    end)
    conn:connect(80, 'baidu.com')
    return _res
end

-- Handle timestamp string
-- "29 Aug 2018 08:24:59" to "2018/08/29 08:24:59"
function _parseRawTimeStamp(rawTimeStamp)
    if (rawTimeStamp == nil or rawTimeStamp == "") then
        return "";
    end
    
    local month = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
    -- Get index of item in Array
    -- Refer to https://stackoverflow.com/a/38283667
    local index={};
    for k,v in pairs(month) do
        index[v]=k;
    end
    
    local day         = mysplit(rawTimeStamp, " ")[1];
    local monthAbbr   = mysplit(rawTimeStamp, " ")[2];
    local year        = mysplit(rawTimeStamp, " ")[3];
    local Time        = mysplit(rawTimeStamp, " ")[4];
    local month = index[monthAbbr];
    if (Time == nil or Time == "") then
        return "";
    end
    
    -- Refer to https://stackoverflow.com/a/10962118
    local hour    = tonumber(mysplit(Time, ":")[1]) + 8;
    local minitue = mysplit(Time, ":")[2];
    local second  = mysplit(Time, ":")[3];
    return string.format("%s\\%02d\\%s %02d:%s:%s", year, month, day, hour, minitue, second);
end

function getCurTime()
    local timeStampRaw = _getCurTime()
    local parsedTimeStamp = _parseRawTimeStamp(timeStampRaw)
    return parsedTimeStamp
end

