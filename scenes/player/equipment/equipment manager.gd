extends Node
	
func get_equipment(item_type, item_name):
	return load("res://scenes/player/equipment/" + item_type + "/" + item_name + ".tscn");