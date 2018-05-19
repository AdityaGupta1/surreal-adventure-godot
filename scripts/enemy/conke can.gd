extends "res://scripts/enemy/enemy.gd"

func _ready():
	bullet = preload("res://scenes/enemies/bullets/conke bottle.tscn");
	shoot_delay = 1;
	._ready();
	
	pass;