--███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
--██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
--█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
--██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
--██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝


ESX, QBCore, vRP, vRPclient = nil, nil, nil, nil

if Config.Framework == 'esx' then
    TriggerEvent(Config.FrameworkTriggers.main, function(obj) ESX = obj end)
    
elseif Config.Framework == 'qbcore' then
    TriggerEvent(Config.FrameworkTriggers.main, function(obj) QBCore = obj end)
    if QBCore == nil then
        QBCore = exports[Config.FrameworkTriggers.resource_name]:GetCoreObject()
    end

elseif Config.Framework == 'vrp' then
    local Proxy = module('vrp', 'lib/Proxy')
    local Tunnel = module('vrp', 'lib/Tunnel')
    vRP = Proxy.getInterface('vRP')
    vRPclient = Tunnel.getInterface('vRP', 'chat_commands')
    
elseif Config.Framework == 'other' then
    --add your own code here.
end

function PermissionsCheck(source, action)
    local data = {}
    if action == 'staff_sit' then
        data = Config.StaffSit.perms[Config.Framework]
    elseif action == 'staff_jail' then
        data = Config.StaffJail.perms[Config.Framework]
    elseif action == 'holy_troll' then
        data = Config.HolyTroll.perms[Config.Framework]
    end
    
    if Config.Framework == 'esx' then 
        local xPlayer = ESX.GetPlayerFromId(source)
        local perms = xPlayer.getGroup()
        for c, d in pairs(data) do
            if perms == d then
                return true
            end
        end
        return false
    
    elseif Config.Framework == 'qbcore' then
        local perms = QBCore.Functions.GetPermission(source)
        for c, d in pairs(data) do
            if type(perms) == 'string' then
                if perms == d then
                    return true
                end
            elseif type(perms) == 'table' then
                if perms[d] then
                    return true
                end
            end
        end
        return false

    elseif Config.Framework == 'vrp' then
        for c, d in pairs(data) do
            if vRP.hasPermission({vRP.getUserId({source}), d}) then 
                return true
            end
        end
        return false

    elseif Config.Framework == 'identifiers' then
        for c, d in pairs(data) do
            for cc, dd in pairs(GetPlayerIdentifiers(source)) do
                if string.lower(dd) == string.lower(d) then
                    return true
                end
            end
        end
        return false

    elseif Config.Framework == 'other' then
        --Add your own permissions check here (boolean).
        return true
        
    end

    return false
end


--███╗   ██╗ ██████╗ ████████╗██╗███████╗██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--████╗  ██║██╔═══██╗╚══██╔══╝██║██╔════╝██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██╔██╗ ██║██║   ██║   ██║   ██║█████╗  ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║╚██╗██║██║   ██║   ██║   ██║██╔══╝  ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
--██║ ╚████║╚██████╔╝   ██║   ██║██║     ██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝


function Notification(source, notif_type, message)
    if notif_type and message then
        if Config.NotificationType.client == 'esx' then
            TriggerClientEvent('esx:showNotification', source, message)
        
        elseif Config.NotificationType.client == 'qbcore' then
            if notif_type == 1 then
                TriggerClientEvent('QBCore:Notify', source, message, 'success')
            elseif notif_type == 2 then
                TriggerClientEvent('QBCore:Notify', source, message, 'primary')
            elseif notif_type == 3 then
                TriggerClientEvent('QBCore:Notify', source, message, 'error')
            end
        
        elseif Config.NotificationType.client == 'mythic_old' then
            if notif_type == 1 then
                TriggerClientEvent('mythic_notify:client:SendAlert:custom', source, { type = 'success', text = message, length = 10000})
            elseif notif_type == 2 then
                TriggerClientEvent('mythic_notify:client:SendAlert:custom', source, { type = 'inform', text = message, length = 10000})
            elseif notif_type == 3 then
                TriggerClientEvent('mythic_notify:client:SendAlert:custom', source, { type = 'error', text = message, length = 10000})
            end

        elseif Config.NotificationType.client == 'mythic_new' then
            if notif_type == 1 then
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = message, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
            elseif notif_type == 2 then
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = message, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
            elseif notif_type == 3 then
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = message, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
            end

        elseif Config.NotificationType.client == 'chat' then
                TriggerClientEvent('chatMessage', source, message)

        elseif Config.NotificationType.client == 'other' then
            --add your own notification.

        end
    end
end