extends "res://scenes/enemies/enemy.gd"

func _ready():
	max_health = 500;
	
	bullet = preload("res://scenes/enemies/stick/smol stick.tscn");
	shoot_delay = 2;
	
	monet = 10;
	
	levitates = true;
	levitate_y = 22.25;
	
	._ready();
	
func _move(delta):
	rotation.y += 4 * PI * delta;