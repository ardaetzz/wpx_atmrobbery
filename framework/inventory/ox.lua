Inventory.HasItem = function(source, item, count)
    return exports.ox_inventory:Search(source, 'count', item) >= (count or 1)
end

Inventory.AddItem = function(source, item, count)
    return exports.ox_inventory:AddItem(source, item, count)
end

Inventory.RemoveItem = function(source, item, count)
    return exports.ox_inventory:RemoveItem(source, item, count)
end
