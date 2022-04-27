if Config.StaffJail.ENABLE then

    local self = {
        location = 0,
        data = {}
    }

    local function EndStaffJail(target_source)
        local staff_data = self.data[target_source].staff
        local player_data = self.data[target_source].player
        SetEntityCoords(player_data.ped, player_data.coords.x, player_data.coords.y, player_data.coords.z)
        TriggerClientEvent('cd_staffsupport:StaffJailTEXT', staff_data.ped)
        TriggerClientEvent('cd_staffsupport:StaffJailTEXT', target_source)

        Notification(staff_data.source, 2, L('staffjail_end_staff', player_data.name, player_data.source))
        Notification(target_source, 1, L('staffjail_end_player', staff_data.name))
        
        self.data[target_source] = nil
    end
    


    RegisterCommand(Config.StaffJail.commands.start, function(source, args, rawcommand)
        if not PermissionsCheck(source, 'staff_jail') then
            Notification(source, 3, L('no_permissions'))
            return
        end
        if type(tonumber(args[1])) ~= 'number' then
            Notification(source, 3, L('playerid_invalid'))
            return
        end
        if not GetPlayerName(tonumber(args[1])) then
            Notification(source, 3, L('player_not_online', args[1]))
            return
        end
        if type(tonumber(args[2])) ~= 'number' then
            Notification(source, 3, L('time_invalid'))
            return
        end
        if type(args[3]) ~= 'string' or (args[3]:lower() ~= L('yes') and args[3]:lower() ~= L('no')) then
            Notification(source, 3, L('should_teleport_invalid'))
            return
        end

        local target_source = tonumber(args[1])
        local time = tonumber(args[2])
        local should_teleport = args[3]:lower() == L('yes') or false
        local reason = rawcommand:gsub('%S+', {[Config.StaffJail.commands.start] = '', [args[1]] = '', [args[2]] = '', [args[3]] = ''}):sub(#args+1)
        if reason == '' then reason = L('no_reason') end

        self.location = self.location + 1
        if self.location > #Config.StaffJail.locations then
            self.location = 1
        end
        
        self.data[target_source] = {}

        local staff_ped = GetPlayerPed(source)
        self.data[target_source].staff = {
            source = source,
            ped = staff_ped,
            name = GetPlayerName(source),
            coords = GetEntityCoords(staff_ped)
        }

        local target_ped = GetPlayerPed(target_source)
        self.data[target_source].player = {
            source = target_source,
            ped = target_ped,
            name = GetPlayerName(target_source),
            coords = GetEntityCoords(target_ped),
            reason = reason
        }

        local coords = Config.StaffJail.locations[self.location]
        if should_teleport then
            SetEntityCoords(source, coords.x, coords.y, coords.z)
        end
        SetEntityCoords(target_ped, coords.x, coords.y, coords.z)

        Notification(source, 2, L('staffjail_start_staff', self.data[target_source].player.name, time, reason))
        Notification(target_source, 3, L('staffjail_start_player', self.data[target_source].staff.name, time, reason))
        
        TriggerClientEvent('cd_staffsupport:StaffJailTEXT', source, coords)
        TriggerClientEvent('cd_staffsupport:StaffJailTEXT', target_source, coords)

        Wait(time*60*1000)

        if self.data[target_source] then
            EndStaffJail(target_source)
        end
    end)



    RegisterCommand(Config.StaffJail.commands.end_, function(source, args)
        if not PermissionsCheck(source, 'staff_jail') then
            Notification(source, 3, L('no_permissions'))
            return
        end
        if type(tonumber(args[1])) ~= 'number' then
            Notification(source, 3, L('playerid_invalid'))
            return
        end
        if not GetPlayerName(tonumber(args[1])) then
            Notification(source, 3, L('player_not_online', args[1]))
            return
        end

        local target_source = tonumber(args[1])
        if self.data[target_source] then
            EndStaffJail(target_source)
        else
            Notification(source, 3, L('not_in_jail'))
        end
    end)



    RegisterCommand(Config.StaffJail.commands.gotojail, function(source, args)
        if not PermissionsCheck(source, 'staff_jail') then
            Notification(source, 3, L('no_permissions'))
            return
        end
        if type(tonumber(args[1])) ~= 'number' then
            Notification(source, 3, L('jailid_invalid_1'))
            return
        end

        local jail_id = tonumber(args[1])
        if jail_id > 0 and jail_id <= #Config.StaffJail.locations then
            local ped = GetPlayerPed(source)
            local coords = Config.StaffJail.locations[jail_id]
            SetEntityCoords(ped, coords.x, coords.y, coords.z)
        else
            Notification(source, 3, L('jailid_invalid_2'))
        end
    end)




    RegisterCommand(Config.StaffJail.commands.lion, function(source, args)
        if not PermissionsCheck(source, 'staff_jail') then
            Notification(source, 3, L('no_permissions'))
            return
        end
        if type(tonumber(args[1])) ~= 'number' then
            Notification(source, 3, L('jailid_invalid_1'))
            return
        end

        local jail_id = tonumber(args[1])
        if jail_id > 0 and jail_id <= #Config.StaffJail.locations then
            local coords = Config.StaffJail.locations[jail_id]
            TriggerClientEvent('cd_staffsupport:StaffJailLion', -1, coords)
        else
            Notification(source, 3, L('jailid_invalid_2'))
        end
    end)

end