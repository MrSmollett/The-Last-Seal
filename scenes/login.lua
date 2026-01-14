local composer = require( "composer" )
local widget = require( "widget" )
local json = require("json")
local fairbase = require("libs.fairbase")

url = "https://thelastseal-1488-default-rtdb.firebaseio.com/"



local scene = composer.newScene()

_H = display.contentHeight --Высота
_W = display.contentWidth --Ширина
_CX = display.contentCenterX
_CY = display.contentCenterY

password = nil
nickname = nil
nicknameChecks = false
passwordChecks = false


function saveData(id, text)
    if id == "NickField" then
        nickname = text

    elseif id == "PasswordField" then
        password = text

    end
end

function checkData()

    local function onEnterFrame(event)
        print( nicknameChecks, passwordChecks )
        if nicknameChecks == passwordChecks then
            Runtime:removeEventListener("enterFrame", onEnterFrame)
            composer.gotoScene( "scenes.choiceConnect" )
        end
    end

    Runtime:addEventListener("enterFrame", onEnterFrame)

    function nicknameCheck(NC)
        if nickname == NC then
            nicknameChecks = true
        else
            print(nickname, NC)
        end
    end
    function passwordCheck(PC)
        if password == PC then
            passwordChecks = true
        else
            print(password, PC)
        end
    end

    if nickname == nil or password == nil then
        print("Проверьте заполненность полей!")
        native.showAlert( "Вход", "Проверьте заполненность полей!", { "OK" } )
    else
        fairbase.getData(url.."usersDate/"..nickname.."/nickname/value/", function(dat) nicknameCheck(string.gsub(dat, '[\\"]', "" )) end)
        fairbase.getData(url.."usersDate/"..nickname.."/password/value/", function(dat) passwordCheck(string.gsub(dat, '[\\"]', "" )) end)
    end
end

function regUser()

    if nickname == nil or password == nil then
        print("Проверьте заполненность полей!")
        native.showAlert( "Регистрация", "Проверьте заполненность полей!", { "OK" } )
    else
        fairbase.updateData(url.."usersDate/"..nickname.."/nickname/", nickname)
        fairbase.updateData(url.."usersDate/"..nickname.."/password/", password)
    end

end


function scene:create( event )

	local sceneGroup = self.view

    print( "Текущая сцена: ".. composer.getSceneName( "current" ) )

    local backgroundIMG = display.newImageRect( sceneGroup, "assets/login/background.png", _W, _H )

end



function scene:show( event )

	local sceneGroup = self.view
        sceneGroup.x, sceneGroup.y = _CX, _CY
	local phase = event.phase

	if ( phase == "will" ) then
		
	elseif ( phase == "did" ) then

        NickField = nil
        PasswordField = nil

        
        local function textListener( event )
            if ( event.phase == "ended" or event.phase == "submitted" ) then
                saveData(event.target.id, event.target.text)
            end
        end
        
        -- Create text field
        NickField = native.newTextField( 0, -100, _W/3, _H/10 )
        NickField.placeholder = "Введите ваш ник"
        NickField.id = "NickField"
        NickField:addEventListener( "userInput", textListener )
        sceneGroup:insert(NickField)

        PasswordField = native.newTextField( 0, 10, _W/3, _H/10 )
        PasswordField.placeholder = "Введите ваш пароль"
        PasswordField.id = "PasswordField"
        PasswordField:addEventListener( "userInput", textListener )
        sceneGroup:insert(PasswordField)


        local function mainMenuBtnPressed( event ) 
            if ( "ended" == event.phase ) then
                if event.target.id == "logBtn" then
                    print( event.target.id )
                    checkData()
                elseif event.target.id == "regBtn" then
                    print( event.target.id )
                    regUser()
                end 
            end
        end
        
        local logBtn = widget.newButton(
            {
                id = "logBtn",
                x = -(PasswordField.width/4),
                y = PasswordField.y+145,
                width = PasswordField.width/2,
                height = _H/6,
                defaultFile = "assets/login/loginBtn.png",
                overFile = "assets/login/loginBtn_pressed.png",
                onEvent = mainMenuBtnPressed
            }
        )
        local regBtn = widget.newButton(
            {
                id = "regBtn",
                x = PasswordField.width/4,
                y = PasswordField.y+145,
                width = PasswordField.width/2,
                height = _H/6,
                defaultFile = "assets/login/registerBtn.png",
                overFile = "assets/login/registerBtn_pressed.png",
                onEvent = mainMenuBtnPressed
            }
        )
        sceneGroup:insert(logBtn)
        sceneGroup:insert(regBtn)

	end
end



function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
        NickField:removeSelf()
        PasswordField:removeSelf()

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