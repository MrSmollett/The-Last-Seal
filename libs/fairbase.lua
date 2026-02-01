M = {}

local json = require("json")



function networkListener(event)
        if event.isError then
            print("Ошибка:", event.response)
        else
            --print("Успешно:", event.response)
            if event.response then
            local responseData = json.decode(event.response)
                --if responseData and responseData.value then
                    -- Полностью заменяем локальную таблицу на серверную (защита от конфликтов)
                    --nicknamesTable = responseData.value
                    --print("[DEBUG] ------ DataGET:" .. responseData)
                    --printNickList(responseData.value)
                --end
            end
            end
    end



M.updateData = function( url, name )

    local params = {
            body = json.encode({ value = name }),
            progress = "download",
            headers = {
                ["Content-Type"] = "application/json"
            }
        }

    network.request(url..".json", "PUT", networkListener, params)
end

M.createKey = function( url, name )

    local params = {
        body = json.encode({ name = name }),
        progress = "download",
        headers = {
            ["Content-Type"] = "application/json"
        }
    }

    network.request(url..".json", "POST", networkListener, params)
end

M.deleteKey = function( url )

    network.request(url..".json", "DELETE", networkListener)

end

M.getData = function(url, FirebaseGet, Name)
--local dataGEt = nil
    local networkGetListener = function(event)
        
        if event.phase == "ended" then
            
            if event.isError then
                print("Ошибка загрузки:", event.response)
            else
                --print(event.isError)
                local dataGEt = json.decode(event.response)
                --print(dataGEt)
                if dataGEt then
                --print(responseData.value)
                    FirebaseGet(dataGEt, Name)
                    
                else
                    --print(dataGEt)
                    FirebaseGet(dataGEt)
                end
            end
        end
    end

    local params = {
        progress = "download",
        }
    
    network.request(url..".json", "GET", networkGetListener, params)
end

return M