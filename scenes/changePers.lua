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



    local backgroundIMG = display.newImageRect( sceneGroup, "assets/login/background.png", _W, _H )


		namePers = {
			gg = {
				name = "Тестовый Гиббон",
				path = "gg"
			}
		}

		direction = "down"

		changedPersID = "gg"

		local pers_prew = display.newImageRect(sceneGroup, "assets/changePers/"..namePers[changedPersID].path.."_"..direction..".png", 404*2, 404*2)
			pers_prew.x, pers_prew.y = -_W/2+_W/6, 0

		local options = 
			{
				text = namePers[changedPersID].name,     
				x = pers_prew.x,
				y = pers_prew.y-pers_prew.height/2-50,
				width = pers_prew.width,
				font = native.systemFont,   
				fontSize = 76,
				align = "center"
			}
		local pers_text = display.newText( options )
			sceneGroup:insert(pers_text)
			--pers_prew.fill = { type = "image", filename = "assets/changePers/gg_up.png" }

		local function rotateBtnPressed( event ) 
            if ( "ended" == event.phase ) then
                if event.target.id == "rotateLeftBtn" then
                    print( event.target.id )

                elseif event.target.id == "rotateRight" then
                    print( event.target.id )

                end
            end
        end
		
        local rotateLeftBtn = widget.newButton(
            {
                id = "rotateLeftBtn",
                x = pers_prew.x-pers_prew.width/4,
                y = pers_prew.y+pers_prew.height/2+50,
                width = pers_prew.width/4,
                height = pers_prew.height/6,
                defaultFile = "assets/errorLoad.png",
                overFile = "assets/errorLoad.png",
                onEvent = rotateBtnPressed
            }
        )
		sceneGroup:insert(rotateLeftBtn)

		local rotateRight = widget.newButton(
            {
                id = "rotateRight",
                x = pers_prew.x+pers_prew.width/4,
                y = pers_prew.y+pers_prew.height/2+50,
                width = pers_prew.width/4,
                height = pers_prew.height/6,
                defaultFile = "assets/errorLoad.png",
                overFile = "assets/errorLoad.png",
                onEvent = rotateBtnPressed
            }
        )
		sceneGroup:insert(rotateRight)
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