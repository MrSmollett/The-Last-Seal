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

urlL = {
    [0] = "Америка",
    [1] = "Европа"
}

servName = LFW.Read("userData.tls")



function scene:create( event )

	local sceneGroup = self.view
        sceneGroup.x, sceneGroup.y = _CX, _CY
    print( "Текущая сцена: "..composer.getSceneName( "current" ) )


        local function mainMenuBtnPressed( event ) 
            if ( "ended" == event.phase ) then
                if event.target.id == "exitBtn" then
                    print( event.target.id )
                    composer.gotoScene( "scenes.mainMenu" )
                end
            end
        end



        exitBtn = widget.newButton(
            {
                id = "exitBtn",
                x = _W/2-_W/9,
                y = -_H/2+_H/9,
                width = _W/9,
                height = _H/9,
                defaultFile = "assets/errorLoad.png",
                overFile = "assets/errorLoad.png",
                onEvent = mainMenuBtnPressed
            }
        )
        sceneGroup:insert(exitBtn)

        
        -- Handle press events for the buttons
        local function onSwitchPress( event )
            local switch = event.target
            if switch.id == "Америка" then
                composer.setVariable( "serverName", 0 )
            else
                composer.setVariable( "serverName", 1 )
            end
        end

        local options = 
            {
                text = "Выбор сервера:",     
                x = -_W/2+350,
                y = -_H/2+100,
                width = 600,
                font = native.systemFont,   
                fontSize = 76,
                align = "left"
            }

        servText = display.newText( options )
        sceneGroup:insert( servText )
        
        local radioGroup = display.newGroup()
            sceneGroup:insert( radioGroup )
            radioGroup.x, radioGroup.y = servText.x, servText.y+120

        serverChange = {}
        serverChangeText = {}
        
        for i=0, #urlL, 1 do
            serverChange[i] = widget.newSwitch(
                {
                    x = 0,
                    y = 100*i,
                    height = 100,
                    width = 100,
                    style = "radio",
                    id = urlL[i],
                    onPress = onSwitchPress
                }
            )

            local options = 
                {
                    text = urlL[i],     
                    id  = urlL[i],
                    x = serverChange[i].x + 350,
                    y = serverChange[i].y,
                    width = 500,
                    font = native.systemFont,   
                    fontSize = 76,
                    align = "left"
                }

            serverChangeText[i] = display.newText( options )

            radioGroup:insert( serverChange[i] )
            radioGroup:insert( serverChangeText[i] )

            if i == #urlL then
                if servName.server == 0 then
                    serverChange[0]:setState( { isOn=true, isAnimated=true} )
                    composer.setVariable( "serverName", 0 )
                else
                    serverChange[1]:setState( { isOn=true, isAnimated=true} )
                    composer.setVariable( "serverName", 1 )
                end
            end
        end


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