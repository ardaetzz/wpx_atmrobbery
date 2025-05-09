Inventory.HasItem = function(source, item, count)
    local player = Framework.GetPlayer(source)
    if not player then return false end

    local hasItem = player.Functions.GetItemByName(item)
    return hasItem and hasItem.amount >= (count or 1) or false
end

Inventory.AddItem = function(source, item, count)
    local player = Framework.GetPlayer(source)
    if not player then return false end

    return player.Functions.AddItem(item, count)
end

Inventory.RemoveItem = function(source, item, count)
    local player = Framework.GetPlayer(source)
    if not player then return false end

    return player.Functions.RemoveItem(item, count)
end
