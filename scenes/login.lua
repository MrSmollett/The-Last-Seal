local composer = require( "composer" )
local widget = require( "widget" )
local json = require("json")
local fairbase = require("libs.fairbase")
local checkDataSc = require("scripts.checkData")
local LFW = require("libs.libFileWork")

serverName = composer.getVariable( "serverName" )

urlList = {
    [0] = "https://thelastseal-1488-default-rtdb.firebaseio.com/",
    [1] = "https://thelastseal-altserver1-default-rtdb.europe-west1.firebasedatabase.app/"
}

url = urlList[serverName]




local scene = composer.newScene()

_H = display.contentHeight --Высота
_W = display.contentWidth --Ширина
_CX = display.contentCenterX
_CY = display.contentCenterY

password = nil
nickname = nil
nicknameChecks = false
passwordChecks = false

blur = display.newImageRect("assets/login/loadData.png", _W, _H)
    blur.x, blur.y = _CX, _CY
    blur.isVisible = false

userDa = LFW.Read("userData.tls")





function saveData(id, text)
    if id == "NickField" then
        nickname = text
    elseif id == "PasswordField" then
        password = text
    end
end

function checkData()


    local count = 1

    local function loginTmL(event)
        --print( nicknameChecks, passwordChecks )
        --print( password, nickname )
        if nicknameChecks == true and passwordChecks == true then
            blur.isVisible = false
            logBtn.isVisible = false
            regBtn.isVisible = false
            timer.cancel( loginTm )
            checkDataSc.checkLoad(nickname, password)
            composer.gotoScene( "scenes.changePers")
        elseif nickname ~= nil or password ~= nil and nicknameChecks == false and passwordChecks == false then
            timer.cancel( loginTm )
            errorAuth()
        end
    end

    loginTm = timer.performWithDelay( 2000, loginTmL )

    function errorAuth()
        native.showAlert( "Вход", "Пользователь не найден!", { "OK" } )
            blur.isVisible = false
            NickField.isVisible = true
            PasswordField.isVisible = true
            logBtn.isVisible = true
            regBtn.isVisible = true
    end

    function nicknameCheck(NC)
        if nickname == NC then
            nicknameChecks = true
        else
            --print(nicknameChecks, nickname, NC)
        end
    end
    function passwordCheck(PC)
        if password == PC then
            passwordChecks = true
        else
            --print(passwordChecks, password, PC)
        end
    end

    if nickname == nil or password == nil then
        print("Проверьте заполненность полей!")
        native.showAlert( "Вход", "Проверьте заполненность полей!", { "OK" } )


    else
        fairbase.getData(url.."usersDate/"..nickname.."/nickname/value/", function(dat) nicknameCheck(dat) end)
        fairbase.getData(url.."usersDate/"..nickname.."/password/value/", function(dat) passwordCheck(dat) end)
        blur.isVisible = true

        logBtn.isVisible = false
        regBtn.isVisible = false
        PasswordField.isVisible = false
        NickField.isVisible = false
    end
end

function regUser()

    if nickname == nil or password == nil then
        print("Проверьте заполненность полей!")
        native.showAlert( "Регистрация", "Проверьте заполненность полей!", { "OK" } )
    elseif #nickname > 15 then
        print("Ник должен быть меньше 15 символов!")
        native.showAlert( "Регистрация", "Ник должен быть меньше 15 символов!", { "OK" } )
    else
        fairbase.updateData(url.."usersDate/"..nickname.."/nickname/", nickname)
        fairbase.updateData(url.."usersDate/"..nickname.."/password/", password)
        blur.isVisible = true
        logBtn.isVisible = false
        regBtn.isVisible = false
        PasswordField.isVisible = false
        NickField.isVisible = false

        local function regTmL(event)
            blur.isVisible = false
            NickField.isVisible = true
            PasswordField.isVisible = true
            logBtn.isVisible = true
            regBtn.isVisible = true
            timer.cancel( regTm )
        end

        regTm = timer.performWithDelay( 2000, regTmL )
    end

end


function scene:create( event )

	local sceneGroup = self.view

    --print( "Текущая сцена: ".. composer.getSceneName( "current" ) )

    local backgroundIMG = display.newImageRect( sceneGroup, "assets/login/background.png", _W, _H )

    print( "Текущая сцена: ".. composer.getSceneName( "current" ) )

        if userDa ~= false then

            composer.gotoScene( "scenes.changePers")

            userDa = json.decode(LFW.Read("userData.tls"))
            checkDataSc.checkLoad(userDa.nickname, userDa.password)

            --print(userDa.nickname, userDa.password)
        end


        

        NickField = nil
        PasswordField = nil

        
        local function textListener( event )
            if (event.phase == "editing") then
                saveData(event.target.id, event.target.text)

            elseif ( event.phase == "ended" or event.phase == "submitted" ) then
                saveData(event.target.id, event.target.text)
                --native.setKeyboardFocus( nil )
            end
        end
        	--print( "Текущая сцена: ".. composer.getSceneName( "current" ) )
        
        -- Create text field
        NickField = native.newTextField( 0, -100, _W/3, _H/10 )
        NickField.placeholder = "Введите ваш ник"
        NickField.id = "NickField"
        NickField:addEventListener( "userInput", textListener )
        sceneGroup:insert(NickField)
        NickField.isVisible = false

        PasswordField = native.newTextField( 0, 10, _W/3, _H/10 )
        PasswordField.placeholder = "Введите ваш пароль"
        PasswordField.id = "PasswordField"
        PasswordField:addEventListener( "userInput", textListener )
        sceneGroup:insert(PasswordField)
        PasswordField.isVisible = false


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
        
        logBtn = widget.newButton(
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
        regBtn = widget.newButton(
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



function scene:show( event )

	local sceneGroup = self.view
        sceneGroup.x, sceneGroup.y = _CX, _CY
	local phase = event.phase
        --print(event.phase)
	if ( phase == "will" ) then
        
        
		
	elseif ( phase == "did" ) then

            NickField.isVisible = true
            PasswordField.isVisible = true

        

	end
end



function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
        if NickField ~= nil and PasswordField ~= nil then
            NickField:removeSelf()
            PasswordField:removeSelf()
        end
        display.remove( sceneGroup )
        sceneGroup = nil
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