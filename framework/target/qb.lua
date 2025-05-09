Target.AddTargetModel = function(models, options)
    return exports['qb-target']:AddTargetModel(models, {
        options = {
            {
                type = "client",
                event = options[1].onSelect and "atmrobbery:client:startRobbery" or "",
                icon = options[1].icon or "fas fa-credit-card",
                label = options[1].label or GetLocale("atm_rob"),
            },
        },
        distance = options[1].distance or 2.0
    })
end

-- QB-Target için gerekli client event
RegisterNetEvent("atmrobbery:client:startRobbery", function()
    local entity = exports['qb-target']:GetCurrentEntity()
    if entity then
        TriggerServerEvent("atmrobbery:tryStart", GetEntityCoords(entity))
    end
end)
