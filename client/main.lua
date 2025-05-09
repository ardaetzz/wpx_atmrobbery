CreateThread(function()
    Wait(5000) -- Framework'ün yüklenmesi için bekle

    Target.AddTargetModel(Config.ATMProps, {
        {
            label = GetLocale("atm_rob"),
            icon = "fas fa-credit-card",
            distance = 1.5,
            onSelect = function(data)
                TriggerServerEvent("atmrobbery:tryStart", GetEntityCoords(data.entity))
            end
        }
    })
end)

RegisterNetEvent("atmrobbery:startMinigame", function()
    -- Animasyon başlat
    local ped = PlayerPedId()
    local animDict = "anim@heists@ornate_bank@hack"

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(10)
    end

    TaskPlayAnim(ped, animDict, "hack_loop", 8.0, 1.0, -1, 2, 0, false, false, false)

    -- Prop ekle
    local model = "prop_cs_tablet"
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end

    local tablet = CreateObject(model, 0.0, 0.0, 0.0, true, true, false)
    AttachEntityToEntity(tablet, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true,
        1, true)

    -- Mini oyunu başlat
    exports['ps-ui']:Scrambler(function(success)
        -- Animasyon ve prop'u temizle
        ClearPedTasks(ped)
        DeleteEntity(tablet)

        TriggerServerEvent("atmrobbery:result", success)
    end, "alphanumeric", 10, 0) -- type, time (seconds), mirrored (0 = no, 1 = yes, 2 = random)
end)
