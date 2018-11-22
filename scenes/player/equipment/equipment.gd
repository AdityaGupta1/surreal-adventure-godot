extends Node

var item_type;
var item_name;
var stats = {};

var equipment_manager;

func get_equipment():
	if equipment_manager == null:
		equipment_manager = load("res://scenes/player/equipment/equipment manager.gd").new();
	
	return equipment_manager.get_equipment(item_type, item_name);