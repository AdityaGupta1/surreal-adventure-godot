extends "res://scripts/bullet.gd"

func _ready():
	lifespan = 3;
	speed = 400;
	damage = 1000;

func should_collide(hit):
	return hit.is_in_group("Enemies");