extends Node

var equipment = {
	"hat": ["fedora", "bottlecap"]
};

var stats = {
	"hat": {"attack": [-1, 5], "defense": [-1, 3], "coolness": [-2, 10]}
};

func get_equipment(item_type, item_name):
	var equipment = load("res://scenes/player/equipment/equipment.gd").new();
	equipment.item_type = item_type;
	equipment.item_name = item_name;
	randomize_stats(equipment);
	return equipment;
	
func get_random_equipment_of_type(item_type):
	var equipment_of_type = equipment[item_type];
	return get_equipment(item_type, equipment_of_type[randi() % equipment_of_type.size()]);
	
func randomize_stats(equipment):
	var possible_stats = stats[equipment.item_type];
	
	for key in possible_stats.keys():
		var stat_range = possible_stats[key];
		equipment.stats[key] = floor(rand_range(stat_range[0], stat_range[1] + 1));
		
	return equipment;
	
func get_price(equipment):
	var price = 0;
	var possible_stats = stats[equipment.item_type];
	
	for key in equipment.stats.keys():
		price += equipment.stats[key] / (possible_stats[key][1] - possible_stats[key][0]);
		
	return max(round(price * 10), 1);