if Config.StaffSit.ENABLE then

    local self = {
        location = 0,
        count = 0,
        data = {}
    }

    local function StaffSit_start(data)
        self.count = self.count + 1
        self.location = self.location + 1
        if self.location > #Config.StaffSit.locations then
            self.location = 1
        end
        self.data[self.count] = {}
        self.data[self.count] = data

        local coords = Config.StaffSit.locations[self.location]
        local target_ids = ''
        
        for c, d in ipairs(data.players) do
            SetEntityCoords(d.ped, coords.x, coords.y, coords.z)
            Notification(d.source, 3, L('staffsit_start_player', data.staff.name))
            target_ids = target_ids..' '..d.name..' ('..d.source..'), '
        end
        target_ids = target_ids:sub(1, -3)
        
        SetEntityCoords(data.staff.ped, coords.x, coords.y, coords.z)
        Notification(data.staff.source, 2, L('staffsit_start_staff', self.count))
        TriggerClientEvent('cd_staffsupport:StaffSitTEXT', data.staff.source, coords, self.count, target_ids)
    end




    RegisterCommand(Config.StaffSit.commands.start, function(source, args)
        if not PermissionsCheck(source, 'staff_jail') then
            Notification(source, 3, L('no_permissions'))
            return
        end

        local can_pass = true
        for c, d in ipairs(args) do
            if type(tonumber(args[c])) == 'number' then
                if not GetPlayerName(tonumber(args[c])) then
                    Notification(source, 3, L('player_not_online', d))
                    can_pass = false
                end
            else
                Notification(source, 3, L('argument_notanumber', c, d))
                can_pass = false
            end
        end
        if not can_pass then return end

        local data = {}
        data.players = {}
        for c, d in ipairs(args) do
            local target_source = tonumber(d)
            local target_ped = GetPlayerPed(target_source)
            data.players[#data.players+1] = {
                source = target_source,
                ped = target_ped,
                coords = GetEntityCoords(target_ped),
                name = GetPlayerName(target_source)
            }
        end

        local staff_ped = GetPlayerPed(source)
        data.staff = {
            source = source,
            ped = staff_ped,
            coords = GetEntityCoords(staff_ped),
            name = GetPlayerName(source)
        }
        
        StaffSit_start(data)
    end)



    RegisterCommand(Config.StaffSit.commands.end_, function(source, args)
        if not PermissionsCheck(source, 'staff_jail') then
            Notification(source, 3, L('no_permissions'))
            return
        end
        if type(tonumber(args[1])) ~= 'number' then
            Notification(source, 3, L('staffsitid_invalid'))
            return
        end

        local current_staffsit = tonumber(args[1])
        local data = self.data[current_staffsit]
        if data then

            for c, d in ipairs(data.players) do
                SetEntityCoords(d.ped, d.coords.x, d.coords.y, d.coords.z)
                Notification(d.source, 1, L('staffsit_end_player', data.staff.name))
            end

            SetEntityCoords(data.staff.ped, data.staff.coords.x, data.staff.coords.y, data.staff.coords.z)
            TriggerClientEvent('cd_staffsupport:StaffSitTEXT', data.staff.source)
            Notification(data.staff.source, 2, L('staffsit_end_staff', current_staffsit))

            self.data[current_staffsit] = nil
            self.location = self.location - 1
            if self.location < 0 then
                self.location = 1
            end
        else
            Notification(source, 3, L('staffsit_notfound'))
        end
    end)



    RegisterCommand(Config.StaffSit.commands.reset, function(source, args)
        if not PermissionsCheck(source, 'staff_jail') then
            Notification(source, 3, L('no_permissions'))
            return
        end
        self.location = 1
        Notification(source, 1, L('staffsit_reset'))
    end)



    RegisterCommand(Config.StaffSit.commands.endall, function(source, args)
        if not PermissionsCheck(source, 'staff_jail') then
            Notification(source, 3, L('no_permissions'))
            return
        end
        for c, d in ipairs(self.data) do
            for cc, dd in ipairs(d.players) do
                SetEntityCoords(dd.ped, dd.coords.x, dd.coords.y, dd.coords.z)
                print('staffsit_ended')
            end
            SetEntityCoords(d.staff.ped, d.staff.coords.x, d.staff.coords.y, d.staff.coords.z)
        end
        self.location = 1
        self.data = {}
        Notification(source, 1, L('staffsit_endall'))
    end)

end