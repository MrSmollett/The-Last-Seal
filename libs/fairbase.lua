M = {}

local json = require("json")



function networkListener(event)
        if event.isError then
            print("Ошибка:", event.response)
        else
            print("Успешно:", event.response)
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

M.getData = function(url, FirebaseGet)
    local dataGet = nil

    local networkGetListener = function(event)
        if event.phase == "ended" then
            if event.isError then
                print("Ошибка загрузки:", event.response)
            else
                dataGet = json.encode(event.response)
                if dataGet then
                    FirebaseGet(dataGet)
                else
                    print("Данные не найдены или ответ пуст")
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