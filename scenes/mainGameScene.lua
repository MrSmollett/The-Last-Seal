local composer = require( "composer" )
local widget = require( "widget" )
local json = require("json")
local fairbase = require("libs.fairbase")
local checkDataSc = require("scripts.checkData")
local LFW = require("libs.libFileWork")
local scripts = require("scripts.mainGameScene")


local map = require("scripts.game.map.mapGenerate")
local character = require("scripts.game.character.hero")


local scene = composer.newScene()





_H = display.contentHeight 		--Высота
_W = display.contentWidth 		--Ширина
_CX = display.contentCenterX
_CY = display.contentCenterY



function scene:create( event )

	local sceneGroup = self.view
        sceneGroup.x, sceneGroup.y = _CX, _CY

    cameraGroup = display.newGroup()
        self.view:insert(cameraGroup)
    
    print( "Текущая сцена: ".. composer.getSceneName( "current" ) )

    map.genMap(1024*5, 1024*5)

    map.showMap(1024*5, 1024*5, cameraGroup)

    character.loadhero(cameraGroup)


		
end



function scene:show( event )

	local sceneGroup = self.view
        sceneGroup.x, sceneGroup.y = _CX, _CY
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then

        --print("[DEBUG] ------ "..event.phase)

        function onEnterFrame()
            
            cameraGroup.x, cameraGroup.y =  -hero.x, -hero.y

        end
        
        Runtime:addEventListener("enterFrame", onEnterFrame)

        



	end
end



function scene:hide( event )

	local sceneGroup = self.view
        sceneGroup.x, sceneGroup.y = _CX, _CY
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then



	end
end



function scene:destroy( event )

	local sceneGroup = self.view
        sceneGroup.x, sceneGroup.y = _CX, _CY



end




scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


return scene