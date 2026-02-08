local composer = require( "composer" )
local widget = require( "widget" )
local json = require("json")
local fairbase = require("libs.fairbase")
local checkDataSc = require("scripts.checkData")
local LFW = require("libs.libFileWork")

local character = require("scripts.game.character.hero")

serverName = composer.getVariable( "serverName" )

urlList = {
    [0] = "https://thelastseal-1488-default-rtdb.firebaseio.com/",
    [1] = "https://thelastseal-altserver1-default-rtdb.europe-west1.firebasedatabase.app/"
}

url = urlList[serverName]

nicknameList = {}
players = {}
heroCreate = 0


function printNickList(nickList)

    nicknameList = nickList
    for num = 1, #nicknameList, 1 do
        createPlayers = nicknameList[num]
        
        if createPlayers ~= userDa.nickname then
                players[createPlayers] = display.newImageRect( cameraGroup, "assets/game/character/hero/gg_down.png", 600, 600 )
                players[createPlayers].id = createPlayers
                    players[createPlayers].text = display.newText(createPlayers, players[createPlayers].x, players[createPlayers].y - players[createPlayers].height/2-100, native.systemFont, 72)
                        cameraGroup:insert(players[createPlayers].text)
            
        print(players[createPlayers].id)
        else
            character.loadhero(cameraGroup)

            function onEnterFrame()
                --debug.text = string.format("FPS: %d | Память: %.1f КБ", display.fps or 0, collectgarbage("count"))
                cameraGroup.x, cameraGroup.y =  -hero.x, -hero.y

            end

            Runtime:addEventListener("enterFrame", onEnterFrame)

            fairbase.getData(url.."usersDate/"..createPlayers.."/posX/value/", function(dat, Nam) hero.x = dat heroCreate = heroCreate + 1 end, createPlayers)
            fairbase.getData(url.."usersDate/"..createPlayers.."/posY/value/", function(dat, Nam) hero.y = dat heroCreate = heroCreate + 1 end, createPlayers)
            character.loadMove()

            
        end
    end
    netWorkTimer = timer.performWithDelay( 500, netWorkTimerListener, 0)
end

function updatePlayers(upDPlayers, tablePl)
    nicknameList = tablePl
        players[upDPlayers] = display.newImageRect( cameraGroup, "assets/game/character/hero/gg_down.png", 600, 600 )
            players[upDPlayers].id = upDPlayers
        players[upDPlayers].text = display.newText(upDPlayers, players[upDPlayers].x, players[upDPlayers].y - players[upDPlayers].height/2-100, native.systemFont, 72)
            cameraGroup:insert(players[upDPlayers].text)
            
        print(players[upDPlayers].id)
end

function setPos(pos, NAMEX)
    transition.to(players[NAMEX].text, {
        x = tonumber(pos),
        time = 300,
        onComplete = function()
            isMoving = false
        end
    })
    
    --print("[DEBUG] ---- nameX:", NAMEX)
    transition.to(players[NAMEX], {
        x = tonumber(pos),
        time = 300,
        onComplete = function()
            isMoving = false
        end
    })
end

function setPosY(pos, NAMEY)
    transition.to(players[NAMEY].text, {
        y = tonumber(pos) - players[NAMEY].height/2-100,
        time = 300,
        onComplete = function()
            isMoving = false
        end
    })
    --print("[DEBUG] ---- nameY:", NAMEY)

    transition.to(players[NAMEY], {
        y = tonumber(pos),
        time = 300,
        onComplete = function()
            isMoving = false
        end
    })
end



function netWorkTimerListener()

    --print(nicknameList[1])
    if heroCreate == 2 then
        fairbase.updateData(url.."usersDate/"..userDa.nickname.."/posX/", hero.x)
        fairbase.updateData(url.."usersDate/"..userDa.nickname.."/posY/", hero.y)
    end
    for num = 1, #nicknameList, 1 do
        setPosName = nicknameList[num]
        --print(#nicknameList)
        if setPosName ~= userDa.nickname then
            --print(setPosName)
            fairbase.getData(url.."usersDate/"..setPosName.."/posX/value/", function(dat, Nam) setPos(dat, Nam) end, setPosName)
            fairbase.getData(url.."usersDate/"..setPosName.."/posY/value/", function(dat, Nam) setPosY(dat, Nam) end, setPosName)
        end
    end

    

    


end








M = {}



return M