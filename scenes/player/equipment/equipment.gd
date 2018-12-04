extends Node

var item_type;
var item_name;
var stats = {};

func get_equipment():
	return load("res://scenes/player/equipment/" + item_type + "/" + item_name + ".tscn");