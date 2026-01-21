local composer = require( "composer" )
local widget = require( "widget" )
local json = require("json")
local fairbase = require("libs.fairbase")
local checkDataSc = require("scripts.checkData")
local LFW = require("libs.libFileWork")


local scene = composer.newScene()


_H = display.contentHeight 		--Высота
_W = display.contentWidth 		--Ширина
_CX = display.contentCenterX
_CY = display.contentCenterY



function scene:create( event )

	local sceneGroup = self.view
        sceneGroup.x, sceneGroup.y = _CX, _CY


		
end



function scene:show( event )

	local sceneGroup = self.view
        sceneGroup.x, sceneGroup.y = _CX, _CY
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then



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