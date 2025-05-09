function LoadLocale(lang)
    local file = LoadResourceFile(GetCurrentResourceName(), 'locale/' .. lang .. '.lua')
    if file then
        local func, err = load(file)
        if func then
            func()
            return true
        else
            print('^1Error loading locale file: ' .. err .. '^0')
        end
    else
        print('^1Locale file not found: locale/' .. lang .. '.lua^0')
    end
    return false
end

function GetLocale(key, ...)
    if not Locale or not Locale[key] then return key end
    return string.format(Locale[key], ...)
end
