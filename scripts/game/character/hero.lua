local composer = require( "composer" )
local widget = require( "widget" )
local json = require("json")
local fairbase = require("libs.fairbase")
local checkDataSc = require("scripts.checkData")
local LFW = require("libs.libFileWork")





Key = {
    w = {x = 0, y = -10},
    s = {x = 0, y = 10},
    a = {x = -10, y = 0},
    d = {x = 10, y = 0},
}






M = {}

    M.loadhero = function(cameraGroup)
        print("[DEBUG] ------ ".."Hero")

        hero = display.newImageRect( cameraGroup, "assets/game/character/hero/gg_down.png", 600, 600 )
    end
        
    M.loadMove = function()

        local speed = 10
        local keys = {}
        direct = {
					s = "_down",
					a = "_left",
					w = "_up",
					d = "_right",
        }


        local function onKeyEvent(event)
            if event.phase == "down" then
                keys[event.keyName] = true
                if event.keyName == "w" then
                    hero.fill = { type = "image", filename = "assets/game/character/hero/gg"..direct[event.keyName]..".png" }

                elseif event.keyName == "s" then
                    hero.fill = { type = "image", filename = "assets/game/character/hero/gg"..direct[event.keyName]..".png" }

                elseif event.keyName == "a" then
                    hero.fill = { type = "image", filename = "assets/game/character/hero/gg"..direct[event.keyName]..".png" }
                
                elseif event.keyName == "d" then
                    hero.fill = { type = "image", filename = "assets/game/character/hero/gg"..direct[event.keyName]..".png" }
                
                end
            elseif event.phase == "up" then
                keys[event.keyName] = false
                --hero.fill = { type = "image", filename = "assets/game/character/hero/gg"..direct.s..".png" }
            end
            return true
        end



        local function onEnterFrame(event)

            local dx, dy = 0, 0
            local moveCount = 0

            if keys.leftShift then
                speed = 15
            else
                speed = 10
            end

            if keys.w then dy = dy - speed; moveCount = moveCount + 1 end
            if keys.s then dy = dy + speed; moveCount = moveCount + 1 end
            if keys.a then dx = dx - speed; moveCount = moveCount + 1 end
            if keys.d then dx = dx + speed; moveCount = moveCount + 1 end

            if moveCount == 2 then
                dx = dx / 1.414
                dy = dy / 1.414
            end

            hero.x = hero.x + dx
            hero.y = hero.y + dy
        end

        -- Подключаем обработчики
        Runtime:addEventListener("key", onKeyEvent)
        Runtime:addEventListener("enterFrame", onEnterFrame)
    end

return M
