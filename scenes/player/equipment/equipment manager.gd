extends Node

var equipment = {
	"hat": ["fedora"]
};

var stats = {
	"hat": {"attack": [-1, 5], "defense": [-1, 3], "coolness": [-2, 10]}
};
	
func get_equipment(item_type, item_name):
	if not equipment.has(item_type):
		print("invalid item type: " + item_type);
		return null;
		
	if not equipment[item_type].has(item_name):
		print("invalid item name: " + item_type + ", " + item_name);
		return null;
	
	return load("res://scenes/player/equipment/" + item_type + "/" + item_name + ".tscn");
	
func randomize_stats(equipment):
	var possible_stats = stats[equipment.item_type];
	
	for key in possible_stats.keys():
		var stat_range = possible_stats[key];
		equipment.stats[key] = floor(rand_range(stat_range[0], stat_range[1] + 1));