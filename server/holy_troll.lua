if Config.HolyTroll.ENABLE then

    RegisterCommand(Config.HolyTroll.commands.start, function(source, args)
        if not PermissionsCheck(source, 'holy_troll') then
            Notification(source, 3, L('no_permissions'))
            return
        end

        if args[1] then
            if type(tonumber(args[1])) ~= 'number' then
                Notification(source, 3, L('playerid_invalid'))
                return
            end
            if not GetPlayerName(tonumber(args[1])) then
                Notification(source, 3, L('player_not_online', args[1]))
                return
            end
            TriggerClientEvent('cd_staffsupport:holytroll', tonumber(args[1]))
            
        else
            TriggerClientEvent('cd_staffsupport:holytroll', source)
        end        
    end)


    RegisterServerEvent('cd_staffsupport:holytroll_playsound')
    AddEventHandler('cd_staffsupport:holytroll_playsound', function(players_table)
        for c, d in pairs(players_table) do
            TriggerClientEvent('cd_staffsupport:holytroll_playsound', d)
        end
    end)

end