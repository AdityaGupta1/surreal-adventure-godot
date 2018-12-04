extends Node

var shopkeepers = ["snail"];

func get_random_shopkeeper():
	var shopkeeper = shopkeepers[randi() % shopkeepers.size()];
	return load("res://scenes/npcs/shopkeepers/" + shopkeeper + "/" + shopkeeper + ".tscn");