extends "res://scenes/bullet.gd"

func _ready():
	lifespan = 3;
	
	var ez_mode = false;
	
	if ez_mode:
		speed = 1000;
		damage = 1000;
	else:
		speed = 400;
		damage = 25;

func _get_collider():
	for body in area.get_overlapping_bodies():
		if body.is_in_group("enemies"):
			return body;
			
	return null;