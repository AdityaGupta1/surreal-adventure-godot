extends "res://scenes/enemies/enemy.gd"

var extended = false;
var return_time = 0;

func _ready():
	max_health = 200;
	
	bullet = preload("res://scenes/enemies/cube/cylinder.tscn");
	shoot_delay = 3;
	
	shotgun_bullets = 4;
	shotgun_angle = 15;
	
	monet = 3;
	
	levitates = true;
	levitate_y = 22.5;
	
	._ready();

func _move(delta):
	if not extended:
		if rand_range(0, 10) < 0.05:
			transform.origin = origin + 3 * Vector3(1 - (randi() % 3), 0, 1 - (randi() % 3));
			extended = true;
			return_time = total_time + 0.5 + rand_range(0, 0.5);
			
	if extended:
		if total_time >= return_time:
			transform.origin = origin;
			extended = false;