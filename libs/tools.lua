M = {}





M.mergeLists = function(list1, list2)
    local result = {}
    
    -- Копируем элементы из первого списка
    for i, v in ipairs(list1) do
        result[#result + 1] = v
    end
    
    -- Добавляем элементы из второго списка
    for i, v in ipairs(list2) do
        result[#result + 1] = v
    end
    
    return result
end

return M