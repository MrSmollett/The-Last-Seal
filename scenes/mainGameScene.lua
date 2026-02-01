local composer = require( "composer" )
local widget = require( "widget" )
local json = require("json")
local fairbase = require("libs.fairbase")
local checkDataSc = require("scripts.checkData")
local LFW = require("libs.libFileWork")
local scripts = require("scripts.mainGameScene")


serverName = composer.getVariable( "serverName" )

urlList = {
    [0] = "https://thelastseal-1488-default-rtdb.firebaseio.com/",
    [1] = "https://thelastseal-altserver1-default-rtdb.europe-west1.firebasedatabase.app/"
}

url = urlList[serverName]


local map = require("scripts.game.map.mapGenerate")
local character = require("scripts.game.character.hero")


local scene = composer.newScene()





_H = display.contentHeight 		--Высота
_W = display.contentWidth 		--Ширина
_CX = display.contentCenterX
_CY = display.contentCenterY



function scene:create( event )
        print( "Текущая сцена: "..composer.getSceneName( "current" ) )

    local sceneGroup = self.view
        sceneGroup.x, sceneGroup.y = _CX, _CY

    userDa = json.decode(LFW.Read("userData.tls"))
        --print(userDa.nickname, userDa.password)
        fairbase.updateData(url.."usersDate/"..userDa.nickname.."/online/", true)
        --fairbase.updateData(url.."usersList/", userDa.nickname)

        checkDataSc.checkOnline(userDa.nickname)

    cameraGroup = display.newGroup()
        self.view:insert(cameraGroup)

    map.showMap(1024*5, 1024*5, cameraGroup)

 
    -- posx = display.newText("X  "..hero.x, -_W/2+250, -_H/2+50, native.systemFont, 72)
    --     sceneGroup:insert(posx)




end



function scene:show( event )

	local sceneGroup = self.view
        sceneGroup.x, sceneGroup.y = _CX, _CY
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then

        --print("[DEBUG] ------ "..event.phase)

        

        


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