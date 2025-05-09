local QBCore = exports['qb-core']:GetCoreObject()

Framework.GetPlayer = function(source)
    return QBCore.Functions.GetPlayer(source)
end

Framework.GetPlayerIdentifier = function(player)
    return player.PlayerData.citizenid
end

Framework.GetPoliceCount = function()
    local policeCount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for _, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            policeCount = policeCount + 1
        end
    end
    return policeCount
end
