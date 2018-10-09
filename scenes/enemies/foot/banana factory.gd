extends "res://scenes/enemies/bullet factory.gd"

func _ready():
	shoot_towards = "absolute";
	shoot_angle = 0;
	
	bullet = preload("res://scenes/enemies/foot/banana.tscn");
	shoot_delay = 7.0/11.0;
	
	shotgun_bullets = 8;
	shotgun_angle = 45;
	
	._ready();