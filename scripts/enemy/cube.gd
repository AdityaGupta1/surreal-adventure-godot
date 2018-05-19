extends "res://scripts/enemy/enemy.gd"

func _ready():
	bullet = preload("res://scenes/enemies/bullets/cylinder.tscn");
	shoot_delay = 3;
	._ready();
	
	pass;