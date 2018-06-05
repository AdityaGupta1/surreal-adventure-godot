extends "res://scenes/enemies/enemy.gd"

func _ready():
	max_health = 150;
	
	bullet = null;
	
	monet = 4;
	
	._ready();