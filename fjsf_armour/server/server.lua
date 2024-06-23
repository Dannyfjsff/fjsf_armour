local ox_inventory = exports.ox_inventory
ESX = exports["es_extended"]:getSharedObject()


RegisterNetEvent("dp_armour:getArmour")
AddEventHandler("dp_armour:getArmour",function (PlayerId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.prepare('SELECT amount FROM player_armour WHERE identifier = ?', {
        identifier
    }, function(response)
    
        if  response ~= nil then
            TriggerClientEvent("dp_armour:addArmour",PlayerId,response)
        end
        
    end)
end)

RegisterNetEvent('dp_armour:saveData')
AddEventHandler('dp_armour:saveData',function (serverId,getArmour)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.ready(function ()
        local identifier = xPlayer.identifier
        local amount = getArmour
        MySQL.prepare('INSERT INTO player_armour (identifier, amount) VALUES (?, ?) ON DUPLICATE KEY UPDATE amount = VALUES(amount)', { identifier, amount })
 
    end)
    TriggerClientEvent("dp_armour:addArmour",serverId,getArmour)
end)

RegisterNetEvent('dp_armour:getData')
AddEventHandler('dp_armour:getData',function (serverId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier
    MySQL.prepare('SELECT amount FROM player_armour WHERE identifier = ?', {
        identifier
    }, function(response)
        
       
        TriggerClientEvent("dp_armour:getData_client",serverId,response)
    end)
end)

RegisterNetEvent('dp_armour:deleteData')
AddEventHandler('dp_armour:deleteData',function (source)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.ready(function ()
        local identifier = xPlayer.identifier
        local amount = 0
        MySQL.prepare('INSERT INTO player_armour (identifier, amount) VALUES (?, ?) ON DUPLICATE KEY UPDATE amount = VALUES(amount)', { identifier, amount })
 
    end)
end)


RegisterNetEvent('dp_armour:remarmour')
AddEventHandler('dp_armour:remarmour',function (serverId,getArmour)

    local success, response = ox_inventory:AddItem(serverId, 'armour_vest', 1,{
        durability = getArmour
    })
    TriggerEvent("dp_armour:deleteData",source)

end)
