extends "res://scenes/enemies/enemy bullet.gd"

func _ready():
	lifespan = 3;
	speed = 20;
	damage = 7;
	
	get_node("splosh").rotation.y = randf() * 2 * PI;