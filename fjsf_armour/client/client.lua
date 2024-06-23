local ox_inventory = exports.ox_inventory

local serverId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(PlayerPedId()))

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    TriggerServerEvent("dp_armour:getArmour",serverId)
end)

local PlayerArmour = 0

RegisterNetEvent('dp_armour:getData_client')
AddEventHandler('dp_armour:getData_client', function(armour)
    PlayerArmour = armour
end)



Citizen.CreateThread(function()
    while true do
        local sleep = Config.RefreshTime 
        local IsLoaded = ESX.IsPlayerLoaded()

        if IsLoaded then
            TriggerServerEvent("dp_armour:getData",serverId)
            local getArmour = GetPedArmour(PlayerPedId())
            if getArmour ~= PlayerArmour then
                TriggerServerEvent("dp_armour:saveData",serverId,getArmour)
            end

        end
        Wait(sleep)
    end
end)



RegisterNetEvent("dp_armour:addArmour")
AddEventHandler("dp_armour:addArmour",function (amount)
    SetPedArmour(PlayerPedId(),amount)

end)

RegisterCommand(Config.RemoveCommand, function()
    local getArmour = GetPedArmour(PlayerPedId())
    if getArmour > 0 then
        TriggerServerEvent("dp_armour:remarmour",serverId,getArmour)
        TriggerEvent("dp_armour:addArmour",0)
        lib.notify({
            title = 'Armour',
            description = 'Armour has been removed',
            type = 'info'
        })
    end
    
  
end)


