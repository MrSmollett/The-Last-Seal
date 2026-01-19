local composer = require( "composer" )
local widget = require( "widget" )
local json = require("json")
local fairbase = require("libs.fairbase")
local LFW = require("libs.libFileWork")

url = "https://thelastseal-1488-default-rtdb.firebaseio.com/"

logDat = {}

M = {}

M.checkLoad = function(nickname, password)

    function loginCheck(login)
        if login == "null" then
            fairbase.updateData(url.."usersDate/"..nickname.."/login/", 1 )
            --данные пользователя
            logDat.nickname = nickname
            logDat.password = password
            logDat.login = 1

        else
            fairbase.updateData(url.."usersDate/"..nickname.."/login/", tonumber(login) + 1 )
            logDat.nickname = nickname
            logDat.password = password
            logDat.login = tonumber(login) + 1
            LFW.Write(json.encode(logDat), "userData.tls")
        end
    end

    fairbase.getData(url.."usersDate/"..nickname.."/login/value", function(dat) loginCheck(string.gsub(dat, '[\\"]', "" )) end)
    

end



return M