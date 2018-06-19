extends "res://scenes/enemies/enemy bullet.gd"

func _ready():
	lifespan = 15;
	speed = 0;
	damage = 15;
	
	rotation.x = rand_range(0, 2 * PI);
	rotation.y = rand_range(0, 2 * PI);
	rotation.z = rand_range(0, 2 * PI);