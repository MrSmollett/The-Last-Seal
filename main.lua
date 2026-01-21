local composer = require("composer")

-- composer.gotoScene( "scenes.mainMenu" )
composer.gotoScene( "scenes.mainMenu" )

if system.getInfo("environment") == "simulator" or system.getInfo("platform") ~= "android" and system.getInfo("platform") ~= "ios" then
    native.setProperty("windowMode", "fullscreen")
end
