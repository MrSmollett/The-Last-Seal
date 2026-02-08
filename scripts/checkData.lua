local composer = require( "composer" )
local widget = require( "widget" )
local json = require("json")
local fairbase = require("libs.fairbase")
local LFW = require("libs.libFileWork")

serverName = composer.getVariable( "serverName" )

urlList = {
    [0] = "https://thelastseal-1488-default-rtdb.firebaseio.com/",
    [1] = "https://thelastseal-altserver1-default-rtdb.europe-west1.firebasedatabase.app/"
}

url = urlList[serverName]

logDat = {}

nicknamesTable = {}
nicknamesTableNew = {}

M = {}

M.checkLoad = function(nickname, password)

    function loginCheck(login)
        if login == nil then
            fairbase.updateData(url.."usersDate/"..nickname.."/login/", 1 )
            --данные пользователя
            logDat.nickname = nickname
            logDat.password = password
            logDat.server = "europe"
            logDat.login = 1
            LFW.Write(json.encode(logDat), "userData.tls")
        else
            fairbase.updateData(url.."usersDate/"..nickname.."/login/", tonumber(login) + 1 )
            logDat.nickname = nickname
            logDat.password = password
            logDat.server = serverName
            logDat.login = tonumber(login) + 1
            LFW.Write(json.encode(logDat), "userData.tls")
        end
    end

    fairbase.getData(url.."usersDate/"..nickname.."/login/value", function(dat) loginCheck(dat) end)
    

end



M.checkOnline = function(nickname)

        -- Глобальная таблица для хранения ников (кэш клиента)
        

        function niceLoadList()
            -- Флаг: идёт ли сейчас синхронизация с сервером
                    local isSyncing = false

                    -- Обработчик ответа от сервера
                    local function networkListener(event)
                        isSyncing = false  -- снимаем флаг синхронизации

                        if event.isError then
                            print("Ошибка сети:", event.response)
                            print("Статус:", event.status)
                            
                            -- Опционально: повторить отправку через время
                            timer.performWithDelay(2000, function()
                                if not isSyncing then
                                    updateData(currentUrl, currentName)  -- нужно сохранить url и name
                                end
                            end)
                        else
                            --print("Успешно отправлено:", event.response)
                            
                            -- Обновляем локальную таблицу из ответа сервера
                            if event.response then
                                local responseData = json.decode(event.response)
                                if responseData and responseData.value then
                                    -- Полностью заменяем локальную таблицу на серверную (защита от конфликтов)
                                    nicknamesTable = responseData.value
                                    print("Локальная таблица обновлена. Игроков: " .. #nicknamesTable)
                                    printNickList(nicknamesTable)
                                end
                            else
                                print("Значение event.response:", event.response)
                            end
                        end
                    end

                    -- Функция: добавить ник и синхронизировать с сервером
                    local currentUrl, currentName  -- для повторной отправки при ошибке

                    function updateData(url, name)
                        -- Проверяем, не идёт ли синхронизация
                        if isSyncing then
                            print("Синхронизация уже идёт, ждём...")
                            return
                        end

                        -- 1. Добавляем ник в локальную таблицу (если его ещё нет)
                        local alreadyExists = false
                        for i, nick in ipairs(nicknamesTable) do
                            if nick == name then
                                alreadyExists = true
                                break
                            end
                        end
                        
                        if not alreadyExists then
                            table.insert(nicknamesTable, name)
                            print("Добавлен ник: " .. name)
                        else
                            print("Ник уже есть в списке: " .. name)
                        end

                        -- 2. Сохраняем текущие параметры для возможной повторной отправки
                        currentUrl = url
                        currentName = name

                        -- 3. Отправляем на сервер обновлённую таблицу
                        local params = {
                            body = json.encode({ value = nicknamesTable }),
                            progress = "download",
                            headers = {
                                ["Content-Type"] = "application/json"
                            }
                        }

                        isSyncing = true  -- ставим флаг синхронизации
                        network.request(url .. ".json", "PUT", networkListener, params)
                    end

                    -- Пример вызова при подключении к комнате
                    local function onRoomConnected(nickname)
                        local firebaseUrl = url.."usersList"
                        updateData(firebaseUrl, nickname)
                    end
                        onRoomConnected(nickname)

        end

        --niceLoadList()
        function loadPlayerList(url)
            network.request(url .. ".json", "GET", function(event)
                if not event.isError then
                    local data = json.decode(event.response)
                    if data and data.value then
                        nicknamesTable = data.value
                        print("Список игроков загружен. Игроков: " .. #nicknamesTable)
                        niceLoadList()

                        
                    end
                else
                    niceLoadList()
                end
            end)
        end
        loadPlayerList(url.."usersList")
        
        
    end

M.updateDataList = function()
    function TEST(url)
        network.request(url .. ".json", "GET", function(event)
            if not event.isError then
                local data = json.decode(event.response)
                if data and data.value then
                    nicknamesTableNew = data.value
                    --print("Список игроков загружен. Игроков: " .. #nicknamesTableNew)
                end
            else
                
            end
        end)
    end
    TEST(url.."usersList")

    for i = 0, #nicknamesTableNew, 1 do
        if nicknamesTableNew[i] == nicknamesTable[i] then
            
        else
            --print(nicknamesTableNew[i])
            nicknamesTable = nicknamesTableNew
            updatePlayers(nicknamesTableNew[i], nicknamesTable)
        end
    end
    
end


return M