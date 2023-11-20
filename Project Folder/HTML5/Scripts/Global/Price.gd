extends Node

var hood_prices = {
	"Neoprne Frisky": {
		"Base" : 159.95,
		"Eyeglass Slots" : 5,
		"Jowl" : 10,
		"Eyelets" : 10
		},
	"Neoprene K9": {
		"Base" : 179.95,
		"Eyeglass Slots" : 5,
		"Jowl" : 10,
		"Eyelets" : 10,
		"Whiskers" : 15,
		"Fur" : 20
		},
	"Neoprene Puppy": {
		"Base" : 139.95,
		"Eyeglass Slots" : 5
		},
	"Neoprene Woof": {
		"Base" : 149.95
		},
	"Muzzle": {
		"Frisky" : {
			"Base" : 59.95,
			"Jowl" : 10,
			"Eyelets" : 10,
			},
		"K9" : {
			"Base" : 54.95,
			"Jowl" : 10,
			"Whiskers" : 10,
			"Fur" : 10
			},
		"Puppy" : {
			"Base" : 44.95
			},
		},
	"Leather K9": {
		"Base" : 389.95,
		"Eyeglass Slots" : 5,
		"Jowl": 20,
		"Whiskers" : 40,
		"Fur" : 40
		}
	}

var price_options = [
	["Eyeglass Slots", "Eyeglass Slots", 1],
	["Jowl", "Jowl", 1],
	["Muzzle Detail B", "Eyelets", 1],
	["Muzzle Detail B", "Whiskers", 2],
	["Muzzle Detail B", "Fur", 3],
]

func _set_price():
	
	var hood_type = hood_prices.get("Muzzle").get(hood_prices.get("Muzzle").keys()[HoodCodeManager.settings[2]]) if HoodCodeManager.settings[0] == 4 else hood_prices.get(hood_prices.keys()[HoodCodeManager.settings[0]])
	var price = hood_type.get("Base")
	
	for i in price_options:
		if HoodCodeManager.settings[HoodCodeManager.node_groups.find(i[0])] == i[2]:
			if hood_type.keys().find(i[1]) != -1:
				price += hood_type.get(i[1])
	get_tree().get_nodes_in_group("Price")[0].text = "$" + String(price)
