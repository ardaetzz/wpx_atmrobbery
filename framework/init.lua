Framework = {}
Inventory = {}
Target = {}
Notify = {}

CreateThread(function()
    print("------------------------------------------------------------------------")
    print("-- wpx_atmrobbery by winprix --")
    print("------------------------------------------------------------------------")

    -- Locale yükleme
    if not LoadLocale(Config.Language) then
        if not LoadLocale('en') then
            print('^1Failed to load any locale files^0')
        end
    end

    -- Framework tespiti
    if Config.Framework == "auto" then
        if GetResourceState('qb-core') ~= 'missing' then
            Config.Framework = "qb"
        elseif GetResourceState('es_extended') ~= 'missing' then
            Config.Framework = "esx"
        else
            print('^1No supported framework detected^0')
            return
        end
    end

    -- Envanter sistemi tespiti
    if Config.InventoryType == "auto" then
        if GetResourceState('ox_inventory') ~= 'missing' then
            Config.InventoryType = "ox"
        elseif GetResourceState('qb-inventory') ~= 'missing' then
            Config.InventoryType = "qb"
        else
            Config.InventoryType = Config.Framework -- Varsayılan olarak framework'ün kendi envanterini kullan
        end
    end

    -- Target sistemi tespiti
    if Config.TargetType == "auto" then
        if GetResourceState('ox_target') ~= 'missing' then
            Config.TargetType = "ox"
        elseif GetResourceState('qb-target') ~= 'missing' then
            Config.TargetType = "qb"
        else
            print('^1No supported target system detected^0')
            return
        end
    end

    -- Framework fonksiyonlarını yükle
    local expected_framework_path = 'framework/' .. Config.Framework .. '.lua'
    local frameworkFile = LoadResourceFile(GetCurrentResourceName(), expected_framework_path)
    if frameworkFile then
        local func, err = load(frameworkFile)
        if func then
            func()
        else
            print('^1Error loading framework file: ' .. err .. '^0')
            return
        end
    else
        print('^1Framework file not found: framework/' .. Config.Framework .. '.lua^0')
        return
    end

    -- Envanter fonksiyonlarını yükle
    local expected_inventory_path = 'framework/inventory/' .. Config.InventoryType .. '.lua'
    local inventoryFile = LoadResourceFile(GetCurrentResourceName(), expected_inventory_path)
    if inventoryFile then
        local func, err = load(inventoryFile)
        if func then
            func()
        else
            print('^1Error loading inventory file: ' .. err .. '^0')
            return
        end
    else
        print('^1Inventory file not found: framework/inventory/' .. Config.InventoryType .. '.lua^0')
        return
    end

    -- Target fonksiyonlarını yükle
    local expected_target_path = 'framework/target/' .. Config.TargetType .. '.lua'
    local targetFile = LoadResourceFile(GetCurrentResourceName(), expected_target_path)
    if targetFile then
        local func, err = load(targetFile)
        if func then
            func()
        else
            print('^1Error loading target file: ' .. err .. '^0')
            return
        end
    else
        print('^1Target file not found: framework/target/' .. Config.TargetType .. '.lua^0')
        return
    end

    -- Bildirim fonksiyonlarını yükle
    local expected_notify_path = 'framework/notify/' .. Config.Framework .. '.lua'
    local notifyFile = LoadResourceFile(GetCurrentResourceName(), expected_notify_path)
    if notifyFile then
        local func, err = load(notifyFile)
        if func then
            func()
        else
            print('^1Error loading notify file: ' .. err .. '^0')
            return
        end
    else
        print('^1Notify file not found: framework/notify/' .. Config.Framework .. '.lua^0')
        return
    end

    print('^2Framework initialized: ' .. Config.Framework .. '^0')
    print('^2Inventory system: ' .. Config.InventoryType .. '^0')
    print('^2Target system: ' .. Config.TargetType .. '^0')
end)
