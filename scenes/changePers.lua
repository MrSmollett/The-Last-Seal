local composer = require( "composer" )
local widget = require( "widget" )
local json = require("json")
local fairbase = require("libs.fairbase")
local checkDataSc = require("scripts.checkData")
local LFW = require("libs.libFileWork")
local scripts = require("scripts.changePers")


local scene = composer.newScene()


_H = display.contentHeight 		--Высота
_W = display.contentWidth 		--Ширина
_CX = display.contentCenterX
_CY = display.contentCenterY




function scene:create( event )

	local sceneGroup = self.view
        sceneGroup.x, sceneGroup.y = _CX, _CY

    print( "Текущая сцена: ".. composer.getSceneName( "current" ) )

    



    --local backgroundIMG = display.newImageRect( sceneGroup, "assets/login/background.png", _W, _H )

		direct = {
			left = {
					[0] = "_down",
					[1] = "_left",
					[2] = "_up",
					[3] = "_right",
			},
			right = {
					[0] = "_down",
					[3] = "_left",
					[2] = "_up",
					[1] = "_right",
			}

		}
		--print(direct[1])

		count = 0


		namePers = {
			gg = {
				name = "Тестовый Гиббон",
				path = "gg"
			}
		}

		direction = "down"

		changedPersID = "gg"

		pers_prew = display.newImageRect(sceneGroup, "assets/changePers/"..namePers[changedPersID].path.."_"..direction..".png", 404*2, 404*2)
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
			pers_prew.fill = { type = "image", filename = "assets/changePers/gg"..direct.left[math.abs(count)]..".png" }

		
        local rotateLeftBtn = widget.newButton(
            {
                id = "rotateLeftBtn",
                x = pers_prew.x-pers_prew.width/6,
                y = pers_prew.y+pers_prew.height/2+55,
                width = pers_prew.width/6,
                height = pers_prew.height/8,
                defaultFile = "assets/changePers/strLeft.png",
                overFile = "assets/changePers/strLeft.png",
                onEvent = rotateBtnPressed
            }
        )
		sceneGroup:insert(rotateLeftBtn)

		local rotateRight = widget.newButton(
            {
                id = "rotateRight",
                x = pers_prew.x+pers_prew.width/6,
                y = pers_prew.y+pers_prew.height/2+55,
                width = pers_prew.width/6,
                height = pers_prew.height/8,
                defaultFile = "assets/changePers/strRight.png",
                overFile = "assets/changePers/strRight.png",
                onEvent = rotateBtnPressed
            }
        )
		sceneGroup:insert(rotateRight)

		local logBtn = widget.newButton(
            {
                id = "logBtn",
                x = _W/2-_W/6,
                y = rotateRight.y,
                width = 300,
                height = 200,
                defaultFile = "assets/changePers/loginBtn.png",
                overFile = "assets/changePers/loginBtn_pressed.png",
                onEvent = UIBtnPressed
            }
        )
		sceneGroup:insert(logBtn)

		local accBtn = widget.newButton(
            {
                id = "accBtn",
                x = _W/2-_W/6,
                y = -rotateRight.y,
                width = 150,
                height = 150,
                defaultFile = "assets/changePers/account.png",
                overFile = "assets/changePers/account_pressed.png",
                onEvent = UIBtnPressed
            }
        )
		sceneGroup:insert(accBtn)

		local settingsBtn = widget.newButton(
            {
                id = "settingsBtn",
                x = accBtn.x + 155,
                y = -rotateRight.y,
                width = 150,
                height = 150,
                defaultFile = "assets/changePers/settings.png",
                overFile = "assets/changePers/settings_pressed.png",
                onEvent = UIBtnPressed
            }
        )
		sceneGroup:insert(settingsBtn)

        eve = {
            phase = "ended",
            target = {
                id = "logBtn"
            }
        }

        function test1()
            UIBtnPressed(eve)
        end

        --timer.performWithDelay( 100, test1, 1 )
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