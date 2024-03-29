extends "res://scenes/enemies/enemy.gd"

func _ready():
	max_health = 160;
	
	bullet = preload("res://scenes/enemies/milk/milk.tscn");
	shoot_delay = 0.1;
	
	shotgun_bullets = 6;
	shotgun_angle = 20;
	
	monet = 3;
	
	shoot_towards = "outward";
	
	levitates = true;
	levitate_y = 21;
	
	._ready();
	
func _move(delta):
	rotation.y += PI * delta;
	transform.origin = origin;
	
func _initial_angle():
	return rotation.y - PI;

func get_no_spawn_radius():
	return 4;