-- Put this code into ox_inventory\modules\items\client.lua under Item('bandage') ... end)

Item('armour_vest', function(data, slot)
	
	if GetPedArmour(cache.ped) < 100 then
		ox_inventory:useItem(data, function(data2)
			if data2 then

				local serverId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(PlayerPedId()))
				TriggerServerEvent("dp_armour:saveData",serverId,data2.metadata.durability)
				lib.notify({
					title = 'Armour',
					description = 'Armour has been applied',
					type = 'success'
				})
			end
		end)
	end
end)

-- Put this code into ox_inventory\data\items.lua

['armour_vest'] = {
	label = 'Bulletproof Vest',
	weight = 5000,
	stack = false,
	durability = 0.1,
	client = {
		anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
		usetime = 3500
	}
}

['armour_plate'] = {
	label = 'Bulletproof Plate',
	weight = 400,
	stack = true,
}

-- Put this code into ox_inventory\data\crafting.lua

{
	items = {
		{
			name = 'armour_vest',
			ingredients = {
				armour_vest = 1,
				armour_plate = 1
			},
			duration = 5000,
			count = 1,
			metadata = { durability = 50 }
		},
		{
			name = 'armour_vest',
			ingredients = {
				armour_vest = 1,
				armour_plate = 2
			},
			duration = 5000,
			count = 1,
			metadata = { durability = 75 }
		},
		{
			name = 'armour_vest',
			ingredients = {
				armour_vest = 1,
				armour_plate = 3
			},
			duration = 5000,
			count = 1,
			metadata = { durability = 100 }
		},

	},
	points = {
		vec3(451.65,-979.84,30.69),
		vec3(21.15,-1106.54,29.69)
		},
	zones = {
		{
			coords = vec3(451.65,-979.84,30.69),
			size = vec3(3.8, 1.05, 0.15),
			distance = 1.5,
			rotation = 175.0,
		},
		{
			coords = vec3(21.15,-1106.54,29.69),
			size = vec3(3.8, 1.05, 0.15),
			distance = 1.5,
			rotation = 175.0,
		},
	},
	-- blip = { id = 566, colour = 31, scale = 0.8 },
},