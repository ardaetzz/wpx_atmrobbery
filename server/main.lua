local PlayerCooldowns = {}
local ATMCooldowns = {}

-- İstatistikler için tablo
local RobberyStats = {
    totalAttempts = 0,
    successfulRobberies = 0,
    totalMoneyStolen = 0
}

-- İstatistikleri kaydetme fonksiyonu
local function SaveRobberyStats()
    SaveResourceFile(GetCurrentResourceName(), "stats.json", json.encode(RobberyStats), -1)
end

-- İstatistikleri yükleme
CreateThread(function()
    local stats = LoadResourceFile(GetCurrentResourceName(), "stats.json")
    if stats then
        RobberyStats = json.decode(stats)
    end
end)

RegisterNetEvent("atmrobbery:tryStart", function(coords)
    local src = source
    local Player = Framework.GetPlayer(src)

    if not Player then
        print("Hata: Oyuncu verisi alınamadı - ID: " .. src)
        return
    end

    local playerId = Framework.GetPlayerIdentifier(Player)

    if PlayerCooldowns[playerId] and PlayerCooldowns[playerId] > GetGameTimer() then
        local timeLeft = math.ceil((PlayerCooldowns[playerId] - GetGameTimer()) / 1000)
        Notify.Error(src, GetLocale("player_cooldown", timeLeft))
        return
    end

    local atmKey = string.format("%.2f_%.2f_%.2f", coords.x, coords.y, coords.z)
    if ATMCooldowns[atmKey] and ATMCooldowns[atmKey] > GetGameTimer() then
        local timeLeft = math.ceil((ATMCooldowns[atmKey] - GetGameTimer()) / 1000)
        Notify.Error(src, GetLocale("atm_cooldown", timeLeft))
        return
    end

    local hasItem = Inventory.HasItem(src, Config.RequiredItem)
    if not hasItem then
        Notify.Error(src, GetLocale("no_item", GetLocale(Config.RequiredItem)))
        return
    end

    -- Mini oyun başlamadan hemen önce ATM için cooldown'ı ayarla
    ATMCooldowns[atmKey] = GetGameTimer() + (Config.ATMCooldown * 1000)

    -- ATM anahtarını oyuncu verisine kaydet (başarısız soygun sonrası kullanmak için)
    Player.atmRobberyKey = atmKey

    -- Polis sayısını kontrol et
    local policeCount = Framework.GetPoliceCount()

    if policeCount < Config.MinimumPolice then
        Notify.Error(src, GetLocale("not_enough_police"))
        ATMCooldowns[atmKey] = nil -- ATM cooldown'ı sıfırla
        return
    end

    if math.random(100) <= Config.PoliceAlertChance then
        TriggerClientEvent(Config.PoliceAlertEvent, -1, coords, GetLocale("police_alert_message"),
            GetLocale("police_alert_description"))
    end

    TriggerClientEvent("atmrobbery:startMinigame", src)
end)

RegisterNetEvent("atmrobbery:result", function(success)
    local src = source
    local Player = Framework.GetPlayer(src)

    if not Player then return end

    local playerId = Framework.GetPlayerIdentifier(Player)

    RobberyStats.totalAttempts = RobberyStats.totalAttempts + 1

    if success then
        local reward = math.random(Config.MinReward, Config.MaxReward)
        Inventory.AddItem(src, Config.RewardItemName, reward)
        Notify.Success(src, GetLocale("success_message", reward))

        if Config.ConsumeItemOnSuccess then
            Inventory.RemoveItem(src, Config.RequiredItem, 1)
        end

        PlayerCooldowns[playerId] = GetGameTimer() + (Config.PlayerCooldown * 1000)

        -- İstatistikleri güncelle
        RobberyStats.successfulRobberies = RobberyStats.successfulRobberies + 1
        RobberyStats.totalMoneyStolen = RobberyStats.totalMoneyStolen + reward
        SaveRobberyStats()
    else
        local atmKey = Player.atmRobberyKey
        if Config.RemoveCooldownOnFail then
            if atmKey then
                ATMCooldowns[atmKey] = nil
            end
        else
            if atmKey and ATMCooldowns[atmKey] then 
                ATMCooldowns[atmKey] = GetGameTimer() + (Config.FailedATMCooldown * 1000)
            end
        end

        Inventory.RemoveItem(src, Config.RequiredItem, 1)
        Notify.Error(src, GetLocale("fail_message", GetLocale(Config.RequiredItem)))
    end
end)

-- İstatistikleri görüntüleme komutu
RegisterCommand("atmstats", function(source, args)
    local src = source
    local Player = Framework.GetPlayer(src)

    if not Player then return end

    local successRate = 0
    if RobberyStats.totalAttempts > 0 then
        successRate = math.floor((RobberyStats.successfulRobberies / RobberyStats.totalAttempts) * 100)
    end

    Notify.Show(src,
        "ATM Soygun İstatistikleri:\nToplam Girişim: " ..
        RobberyStats.totalAttempts ..
        "\nBaşarılı Soygun: " ..
        RobberyStats.successfulRobberies ..
        "\nBaşarı Oranı: %" .. successRate .. "\nToplam Çalınan Para: $" .. RobberyStats.totalMoneyStolen, "primary")
end, false)

-- Sunucu yeniden başlatıldığında veya kaynak durdurulduğunda cooldown tablolarını temizle
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PlayerCooldowns = {}
        ATMCooldowns = {}
        SaveRobberyStats()
    end
end)
