extends "res://scenes/enemies/enemy.gd"

func _ready():
	max_health = 160;
	
	bullet = preload("res://scenes/enemies/milk/milk.tscn");
	shoot_delay = 1;
	
	shotgun_bullets = 1;
	shotgun_angle = 1;
	
	monet = 1;
	
	shoot_origin = "origin";
	shoot_offset = Vector3(0, 1, 0);
	shoot_towards = "outward";
	
	._ready();
	
func _move(delta):
	rotation.y += PI * delta;