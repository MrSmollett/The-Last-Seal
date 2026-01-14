local composer = require( "composer" )
local widget = require( "widget" )
local json = require("json")
--local fairbase = require("libs.fairbase")



local scene = composer.newScene()

_H = display.contentHeight --Высота
_W = display.contentWidth --Ширина
_CX = display.contentCenterX
_CY = display.contentCenterY


function scene:create( event )

	local sceneGroup = self.view

    print( "Текущая сцена: ".. composer.getSceneName( "current" ) )

    local backgroundIMG = display.newImageRect( sceneGroup, "assets/choiceConnect/background.png", _W, _H )


end




function scene:show( event )

	local sceneGroup = self.view
        sceneGroup.x, sceneGroup.y = _CX, _CY
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then

        local function mainMenuBtnPressed( event ) 
            if ( "ended" == event.phase ) then
                if event.target.id == "lobbyBtn" then
                    print( event.target.id )

                elseif event.target.id == "randomConnectBtn" then
                    print( event.target.id )

                end
            end
        end

        local lobbyBtn = widget.newButton(
            {
                id = "lobbyBtn",
                x = 0,
                y = 0,
                width = _W/5,
                height = _H/6,
                defaultFile = "assets/choiceConnect/lobbyBtn.png",
                overFile = "assets/choiceConnect/lobbyBtn_pressed.png",
                onEvent = mainMenuBtnPressed
            }
        )

        local randomConnectBtn = widget.newButton(
            {
                id = "randomConnectBtn",
                x = 0,
                y = lobbyBtn.y + _H/7,
                width = _W/5,
                height = _H/6,
                defaultFile = "assets/choiceConnect/randomConnectBtn.png",
                overFile = "assets/choiceConnect/randomConnectBtn_pressed.png",
                onEvent = mainMenuBtnPressed
            }
        )

        sceneGroup:insert(lobbyBtn)
        sceneGroup:insert(randomConnectBtn)

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