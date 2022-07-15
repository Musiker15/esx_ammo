ESX = nil
TriggerEvent(Config.getSharedObject, function(obj) ESX = obj end)

ESX.RegisterUsableItem(Config.Item, function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.triggerEvent('esx_ammo:checkWeapon')
end)

RegisterNetEvent('esx_ammo:giveWeaponAmmo')
AddEventHandler('esx_ammo:giveWeaponAmmo', function(weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local hasItem = xPlayer.getInventoryItem(Config.Item).count

    if xPlayer then
        if hasItem >= 1 then
            xPlayer.addWeaponAmmo(weaponName, Config.Ammo)
            xPlayer.removeInventoryItem(Config.Item, 1)
            xPlayer.showNotification('You used a ammo clip')
        else
            xPlayer.showNotification('You need a ammo clip to reload your weapon')
        end
    end
end)

---- GitHub Updater ----
function GetCurrentVersion()
	return GetResourceMetadata( GetCurrentResourceName(), "version" )
end

local CurrentVersion = GetCurrentVersion()
local resourceName = "^4["..GetCurrentResourceName().."]^0"

if Config.VersionChecker then
	PerformHttpRequest('https://raw.githubusercontent.com/Musiker15/esx_ammo/main/VERSION', function(Error, NewestVersion, Header)
		print("###############################")
    	if CurrentVersion == NewestVersion then
	    	print(resourceName .. '^2 ✓ Resource is Up to Date^0 - ^5Current Version: ^2' .. CurrentVersion .. '^0')
    	elseif CurrentVersion ~= NewestVersion then
        	print(resourceName .. '^1 ✗ Resource Outdated. Please Update!^0 - ^5Current Version: ^1' .. CurrentVersion .. '^0')
	    	print('^5Newest Version: ^2' .. NewestVersion .. '^0 - ^6Download here: ^9https://github.com/Musiker15/esx_ammo/releases/tag/v'.. NewestVersion .. '^0')
    	end
		print("###############################")
	end)
else
	print("###############################")
	print(resourceName .. '^2 ✓ Resource loaded^0')
	print("###############################")
end