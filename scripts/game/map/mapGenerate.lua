local composer = require( "composer" )
local widget = require( "widget" )
local json = require("json")
local fairbase = require("libs.fairbase")
local checkDataSc = require("scripts.checkData")
local LFW = require("libs.libFileWork")












M = {}

    M.genMap = function(W, H)
        print("[DEBUG] ------ ".."Map H: "..H.."  ".."Map W: "..W)
        
    end

    M.showMap = function(W, H, cameraGroup)
        print("[DEBUG] ------ ".."Map")

        map = display.newImageRect( "assets/game/map/grass.png", W, H )
            cameraGroup:insert(map)

        
    end



return M