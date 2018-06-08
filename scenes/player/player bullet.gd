extends "res://scripts/bullet.gd"

func _ready():
	lifespan = 3;
	speed = 400;
	damage = 25;

func _get_collider():
	for body in area.get_overlapping_bodies():
		if body.is_in_group("enemies"):
			return body;
			
	return null;