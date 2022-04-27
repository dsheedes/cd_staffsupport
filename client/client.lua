local function Text(x, y, z, text)
	SetTextFont(4)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry('STRING')
	AddTextComponentString(text)
	SetDrawOrigin(x, y, z, 0)
	DrawText(0.0, 0.0)
	ClearDrawOrigin()
end

local in_staffjail = false
RegisterNetEvent('cd_staffsupport:StaffJailTEXT')
AddEventHandler('cd_staffsupport:StaffJailTEXT', function(coords)
	if coords then
		in_staffjail = true
		while in_staffjail do
			Wait(0)
			if #(coords-GetEntityCoords(PlayerPedId())) < 10.0 then
				Text(coords.x, coords.y, coords.z+1.0, L('staffjail_clienttext_1'))
				Text(coords.x, coords.y, coords.z+0.7, L('staffjail_clienttext_2'))
				Text(coords.x, coords.y, coords.z+0.4, L('staffjail_clienttext_3'))
			end
		end
	else
		in_staffjail = false
	end
end)



RegisterNetEvent('cd_staffsupport:StaffJailLion')
AddEventHandler('cd_staffsupport:StaffJailLion', function(coords)
	local hash = `a_c_mtlion`
	RequestModel(hash)
	while not HasModelLoaded(hash) do
	Wait(155)
	end
	
	local player = PlayerPedId()
	local ped = CreatePed(4, hash, coords.x, coords.y, coords.z, 227.92, true, true)
	SetEntityMaxHealth(ped, 1000)
	SetEntityHealth(ped, 1000)
	SetPedCombatAttributes(ped, 46, 1)
	SetPedCombatMovement(ped, 3)
	SetPedCombatRange(ped, 1)
	TaskCombatPed(ped, player, 0, 16)
end)

local in_staffsit = false
RegisterNetEvent('cd_staffsupport:StaffSitTEXT')
AddEventHandler('cd_staffsupport:StaffSitTEXT', function(coords, text, target_ids)
	if coords then
		in_staffsit = true
		while in_staffsit do
			Wait(0)
			if #(coords-GetEntityCoords(PlayerPedId())) < 10.0 then
				Text(coords.x, coords.y, coords.z+1.0, L('staffsit_clienttext_1', text))
				Text(coords.x, coords.y, coords.z+0.7, L('staffsit_clienttext_2', target_ids))
			end
		end
	else
		in_staffsit = false
	end
end)



local function PlayAnimation(dict, name, duration)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) end
    TaskPlayAnim(PlayerPedId(), dict, name, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(dict)
end

local function HandleProp(action, ped, ped_coords, prop)
    if action == 'add' then
        local prop = CreateObject(`prop_novel_01`, ped_coords.x, ped_coords.y, ped_coords.z,  true,  true, true) 
        AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 6286), 0.15, 0.03, -0.065, 0.0, 180.0, 90.0, true, true, false, true, 1, true)
        PlayAnimation('cellphone@', 'cellphone_text_read_base', 10000)
        return prop

    elseif action == 'remove' then
        ClearPedSecondaryTask(ped)
        SetEntityAsMissionEntity(prop)
        DeleteObject(prop)
    end
end

local function GetClosestPlayers(ped_coords)
    local temp_table = {}
    for c, d in pairs(GetActivePlayers()) do
        local targetped = GetPlayerPed(d)
        local dist = #(ped_coords-GetEntityCoords(targetped))
        if dist < 20 then
            table.insert(temp_table, GetPlayerServerId(d))
        end
    end
    return temp_table
end

local function EndHolyTroll(ped, ped_coords)
    SetEntityCoords(ped, ped_coords.x, ped_coords.y, ped_coords.z)
    Wait(500)
    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_BUM_SLUMPED', 0, true)
    Wait(5000)
    ClearPedTasksImmediately(ped)
end

RegisterNetEvent('cd_staffsupport:holytroll_playsound')
AddEventHandler('cd_staffsupport:holytroll_playsound', function()
    SendNUIMessage({sound = 'holytroll1'})
end)

local self = {
	looped = 0,
	done = false,
	halfway = false,
}

RegisterNetEvent('cd_staffsupport:holytroll')
AddEventHandler('cd_staffsupport:holytroll', function()
    local ped = PlayerPedId()
    local ped_coords = GetEntityCoords(ped)
    local prop = HandleProp('add', ped, ped_coords)
	Notification(2, L('holytroll_read_bible'))
    Wait(10500)
    HandleProp('remove', ped, false, prop)
    TriggerServerEvent('cd_staffsupport:holytroll_playsound', GetClosestPlayers(ped_coords))

    self.looped = 0
    self.halfway = false

    Notification(2, L('holytroll_lord_judging_1'))
    while true do
        Wait(300)
        if self.looped < 6 then
            self.looped = self.looped + 0.3
            FreezeEntityPosition(ped, false)
            SetEntityCoords(ped, ped_coords.x, ped_coords.y, ped_coords.z + self.looped)
            FreezeEntityPosition(ped, true)

        elseif self.looped > 6 and self.looped < 1000 then
            self.looped = self.looped + 200
            FreezeEntityPosition(ped, false)
            SetEntityCoords(ped, ped_coords.x, ped_coords.y, ped_coords.z + self.looped)
            FreezeEntityPosition(ped, true)

        elseif self.looped > 1000 then
			Notification(2, L('holytroll_lord_judging_2'))
            Wait(5000)
            SendNUIMessage({sound = 'holytroll2'})
            Wait(5000)
            FreezeEntityPosition(ped, false)
            if math.random(1, 2) == 1 then
                Notification(1, L('holytroll_approved_1'))
                Wait(5000)
                Notification(3, L('holytroll_approved_2'))
                Wait(10000)
                TriggerEvent('cd_staffsupport:holytroll_spawnfish', ped)
                Wait(10000)
                EndHolyTroll(ped, ped_coords)                
            else
                Notification(3, L('holytroll_disapproved'))
                TriggerEvent('cd_staffsupport:holytroll_falling', ped, ped_coords)
            end
			break
        end
    end
end)

RegisterNetEvent('cd_staffsupport:holytroll_falling')
AddEventHandler('cd_staffsupport:holytroll_falling', function(ped, ped_coords)
    Wait(2000)
    while true do
        Wait(0)
        if IsPedFalling(ped) then
            local ped_coords2 = GetEntityCoords(ped)
            local dist = #(ped_coords-ped_coords2)
            if dist < 500 and not self.halfway then
                self.halfway = true
                SetEntityCoords(ped, ped_coords.x, ped_coords.y, ped_coords.z + 500)
                FreezeEntityPosition(ped, true)
                Notification(1, L('holytroll_2nd_chance'))
                Wait(5000)
                if math.random(1, 2) == 1 then
                    FreezeEntityPosition(ped, false)
                    Notification(1, L('holytroll_approved_3'))
                    Wait(5000)
                    Notification(3, L('holytroll_approved_2'))
                    Wait(3000)
                    TriggerEvent('cd_staffsupport:holytroll_spawnfish', ped)
                    Wait(10000)
                    EndHolyTroll(ped, ped_coords)
                else
                    Notification(3, L('holytroll_disapproved_2'))
                    FreezeEntityPosition(ped, false)
                end
            elseif dist <= 40.0 then
                EndHolyTroll(ped, ped_coords)
                break
            end
        end
    end
end)

RegisterNetEvent('cd_staffsupport:holytroll_spawnfish')
AddEventHandler('cd_staffsupport:holytroll_spawnfish', function(ped)
    Notification(1, L('holytroll_being_blessed'))
    SetEntityCoords(ped, Config.HolyTroll.ped_location.x, Config.HolyTroll.ped_location.y, Config.HolyTroll.ped_location.z)
    SetEntityHeading(ped, Config.HolyTroll.ped_location.w)
	local temp_fish_table = {}
	temp_fish_table.ped = {}
	temp_fish_table.hash = {}
	for c, d in pairs(Config.HolyTroll.locations) do
		RequestModel(d[0])
		while not HasModelLoaded(d[0]) do
			Wait(1)
		end
		table.insert(temp_fish_table.hash, d[0])
		for cd = 1, #d do
			local fish = CreatePed(4, d[0], d[cd].spawn_coords.x, d[cd].spawn_coords.y, d[cd].spawn_coords.z, d[cd].spawn_coords.w, false, true)
			TaskGoStraightToCoord(fish, d[cd].goto_coords.x, d[cd].goto_coords.y, d[cd].goto_coords.z, 1.0, 1.0, 1.0, 1.0)
			table.insert(temp_fish_table.ped, fish)
		end
	end

    Wait(10000)
	for c, d in pairs(temp_fish_table.hash) do
		SetModelAsNoLongerNeeded(d)
	end
    for c, d in pairs(temp_fish_table.ped) do
        SetPedAsNoLongerNeeded(d)
        SetEntityAsNoLongerNeeded(d)
		SetModelAsNoLongerNeeded(d)
        DeleteEntity(d)
	end
end)