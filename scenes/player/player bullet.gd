extends "res://scenes/bullet.gd"

func _ready():
	lifespan = 3;
#	speed = 400;
#	damage = 25;
	speed = 1000;
	damage = 1000;

func _get_collider():
	for body in area.get_overlapping_bodies():
		if body.is_in_group("enemies"):
			return body;
			
	return null;