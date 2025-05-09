Notify = {}

Notify.Show = function(source, message, type)
    TriggerClientEvent('QBCore:Notify', source, message, type or 'primary')
end

Notify.Error = function(source, message)
    Notify.Show(source, message, 'error')
end

Notify.Success = function(source, message)
    Notify.Show(source, message, 'success')
end
