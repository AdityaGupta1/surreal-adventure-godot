extends "res://scenes/enemies/enemy.gd"

func _ready():
	max_health = 100;
	
	bullet = preload("res://scenes/enemies/conke can/conke bottle.tscn");
	shoot_delay = 1;
	
	shotgun_bullets = 3;
	shotgun_angle = 20;
	
	monet = 2;
	
	._ready();
	
func _move(delta):
	transform.origin = origin + 2 * Vector3((1 + cos(4 * total_time)) * cos(total_time), 0, (1 + cos(4 * total_time)) * sin(total_time));