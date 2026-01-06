local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

_H = display.contentHeight --Высота
_W = display.contentWidth --Ширина
_CX = display.contentCenterX
_CY = display.contentCenterY


function scene:create( event )

	local sceneGroup = self.view


end



function scene:show( event )

	local sceneGroup = self.view
        sceneGroup.x, sceneGroup.y = _CX, _CY

	local phase = event.phase

	if ( phase == "will" ) then
		
        local backgroundIMG = display.newImageRect( sceneGroup, "assets/errorLoad.png", _W, _H )

	elseif ( phase == "did" ) then

        local function mainMenuBtnPressed( event ) 
            if ( "ended" == event.phase ) then
                print( event.target.id )
            end
        end
        
        local playBtn = widget.newButton(
            {
                id = "playBtn",
                x = 0 - _W/4,
                y = 0,
                width = _W/4,
                height = _H/5,
                defaultFile = "assets/mainMenu/playBtn.png",
                overFile = "assets/mainMenu/playBtn_pressed.png",
                onEvent = mainMenuBtnPressed
            }
        )
                
        local optionsBtn = widget.newButton(
            {
                id = "optionsBtn",
                x = 0 - _W/4,
                y = playBtn.y + _H/6,
                width = _W/4,
                height = _H/5,
                defaultFile = "assets/mainMenu/optionsBtn.png",
                overFile = "assets/mainMenu/optionsBtn_pressed.png",
                onEvent = mainMenuBtnPressed
            }
        )

        local quitBtn = widget.newButton(
            {
                id = "quitBtn",
                x = 0 - _W/4,
                y = optionsBtn.y + _H/6,
                width = _W/4,
                height = _H/5,
                defaultFile = "assets/mainMenu/quitBtn.png",
                overFile = "assets/mainMenu/quitBtn_pressed.png",
                onEvent = mainMenuBtnPressed
            }
        )


        sceneGroup:insert(playBtn)
        sceneGroup:insert(optionsBtn)
        sceneGroup:insert(quitBtn)

	end
end



function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then

	end
end



function scene:destroy( event )

	local sceneGroup = self.view

end




scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


return scene