extends "res://scripts/bullet.gd"

func should_collide(hit):
	return hit.get_name() == "Player";