--███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
--██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
--█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
--██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
--██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝


ESX, QBCore = nil, nil

Citizen.CreateThread(function()
    if Config.Framework == 'esx' then
        while ESX == nil do
            TriggerEvent(Config.FrameworkTriggers.main, function(obj) ESX = obj end)
            Citizen.Wait(100)
        end
    
    elseif Config.Framework == 'qbcore' then
        while QBCore == nil do
            TriggerEvent(Config.FrameworkTriggers.main, function(obj) QBCore = obj end)
            if QBCore == nil then
                QBCore = exports[Config.FrameworkTriggers.resource_name]:GetCoreObject()
            end
            Citizen.Wait(100)
        end
        
    elseif Config.Framework == 'other' then
        --add your framework code here.

    end
end)


-- ██████╗██╗  ██╗ █████╗ ████████╗     ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
--██╔════╝██║  ██║██╔══██╗╚══██╔══╝    ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
--██║     ███████║███████║   ██║       ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
--██║     ██╔══██║██╔══██║   ██║       ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
--╚██████╗██║  ██║██║  ██║   ██║       ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
-- ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝        ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝


if Config.StaffSit.ENABLE then
    TriggerEvent('chat:addSuggestion', '/'..Config.StaffSit.commands.start, L('chatsuggest_staffsit_start_1'), { {name = L('chatsuggest_player_id'), help = L('chatsuggest_staffsit_start_2')}, {name = L('chatsuggest_player_id'), help = L('chatsuggest_staffsit_start_3')}, {name = L('chatsuggest_player_id'), help = L('chatsuggest_staffsit_start_3')}, {name = L('chatsuggest_player_id'), help = L('chatsuggest_staffsit_start_3')}, {name = L('chatsuggest_player_id'), help = L('chatsuggest_staffsit_start_3')} })
    TriggerEvent('chat:addSuggestion', '/'..Config.StaffSit.commands.end_, L('chatsuggest_staffsit_end_1'), { {name = L('chatsuggest_staffsit_end_2'), help = L('chatsuggest_staffsit_end_3')} })
    TriggerEvent('chat:addSuggestion', '/'..Config.StaffSit.commands.reset, L('chatsuggest_staffsit_reset_1') )
    TriggerEvent('chat:addSuggestion', '/'..Config.StaffSit.commands.endall, L('chatsuggest_staffsit_endall_1') )
end

if Config.StaffJail.ENABLE then
    TriggerEvent('chat:addSuggestion', '/'..Config.StaffJail.commands.start, L('chatsuggest_staffjail_start_1'), { {name = L('chatsuggest_player_id'), help = L('chatsuggest_staffjail_start_2')}, {name = L('chatsuggest_staffjail_start_3'), help = L('chatsuggest_staffjail_start_4')}, {name = L('chatsuggest_staffjail_start_5'), help = L('chatsuggest_staffjail_start_6', L('yes'), L('no'))}, {name = L('chatsuggest_staffjail_start_7'), help = L('chatsuggest_staffjail_start_8')} })
    TriggerEvent('chat:addSuggestion', '/'..Config.StaffJail.commands.end_, L('chatsuggest_staffjail_end_1'), { {name = L('chatsuggest_player_id'), help = L('chatsuggest_staffjail_end_2')} })
    TriggerEvent('chat:addSuggestion', '/'..Config.StaffJail.commands.gotojail, L('chatsuggest_staffjail_goto_1'), { {name = L('chatsuggest_staffjail_goto_2'), help = L('chatsuggest_staffjail_goto_3', #Config.StaffJail.locations)} })
    TriggerEvent('chat:addSuggestion', '/'..Config.StaffJail.commands.lion, L('chatsuggest_staffjail_lion_1'), { {name = L('chatsuggest_staffjail_goto_2'), help = L('chatsuggest_staffjail_goto_3', #Config.StaffJail.locations)} })
end

if Config.HolyTroll.ENABLE then
    TriggerEvent('chat:addSuggestion', '/'..Config.HolyTroll.commands.start, L('chatsuggest_holytroll__1'), { {name = L('chatsuggest_player_id'), help = L('chatsuggest_holytroll__2')} })
end


--███╗   ██╗ ██████╗ ████████╗██╗███████╗██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--████╗  ██║██╔═══██╗╚══██╔══╝██║██╔════╝██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██╔██╗ ██║██║   ██║   ██║   ██║█████╗  ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║╚██╗██║██║   ██║   ██║   ██║██╔══╝  ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
--██║ ╚████║╚██████╔╝   ██║   ██║██║     ██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝


function Notification(notif_type, message)
    if notif_type and message then
        if Config.NotificationType.client == 'esx' then
            ESX.ShowNotification(message)
        
        elseif Config.NotificationType.client == 'qbcore' then
            if notif_type == 1 then
                QBCore.Functions.Notify(message, 'success')
            elseif notif_type == 2 then
                QBCore.Functions.Notify(message, 'primary')
            elseif notif_type == 3 then
                QBCore.Functions.Notify(message, 'error')
            end

        elseif Config.NotificationType.client == 'mythic_old' then
            if notif_type == 1 then
                exports['mythic_notify']:DoCustomHudText('success', message, 10000)
            elseif notif_type == 2 then
                exports['mythic_notify']:DoCustomHudText('inform', message, 10000)
            elseif notif_type == 3 then
                exports['mythic_notify']:DoCustomHudText('error', message, 10000)
            end

        elseif Config.NotificationType.client == 'mythic_new' then
            if notif_type == 1 then
                exports['mythic_notify']:SendAlert('success', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            elseif notif_type == 2 then
                exports['mythic_notify']:SendAlert('inform', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            elseif notif_type == 3 then
                exports['mythic_notify']:SendAlert('error', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            end

        elseif Config.NotificationType.client == 'chat' then
            TriggerEvent('chatMessage', message)
            
        elseif Config.NotificationType.client == 'other' then
            --add your own notification.
            
        end
    end
end