extends Node

var equipment = {
	"hat": ["fedora"]
};
	
func get_equipment(item_type, item_name):
	if not equipment.has(item_type):
		print("invalid item type: " + item_type);
		return;
		
	if not equipment[item_type].has(item_name):
		print("invalid item name: " + item_type + ", " + item_name);
		return;
	
	return load("res://scenes/player/equipment/" + item_type + "/" + item_name + ".tscn");