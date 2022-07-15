ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.getSharedObject, function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx_ammo:checkWeapon')
AddEventHandler('esx_ammo:checkWeapon', function()
    local playerPed = PlayerPedId()
    local hash = GetSelectedPedWeapon(playerPed)
    
    if IsPedArmed(playerPed, 4) then
        if hash ~= nil then
            local weapon = ESX.GetWeaponFromHash(hash)

            TaskReloadWeapon(playerPed, 1)
            Citizen.Wait(2000)
			ClearPedTasks(playerPed)
            TriggerServerEvent('esx_ammo:giveWeaponAmmo', weapon.name)
        end
    end
end)

if Config.useHotkey then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if IsControlJustPressed(1, Config.Hotkey) then
				local playerPed = PlayerPedId()
				local hash = GetSelectedPedWeapon(playerPed)

				if IsPedArmed(playerPed, 4) then
					if hash ~= nil then
                        local weapon = ESX.GetWeaponFromHash(hash)

                        TaskReloadWeapon(playerPed, 1)
                        Citizen.Wait(2000)
			            ClearPedTasks(playerPed)
						TriggerServerEvent('esx_ammo:giveWeaponAmmo', weapon.name)
                    end
				end
			end
		end
	end)
end