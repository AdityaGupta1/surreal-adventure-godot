extends "res://scenes/enemies/enemy.gd"

func _ready():
	max_health = 200;
	
	bullet = preload("res://scenes/enemies/cube/cylinder.tscn");
	shoot_delay = 3;
	
	shotgun_bullets = 4;
	shotgun_angle = 15;
	
	._ready();
	
	pass;