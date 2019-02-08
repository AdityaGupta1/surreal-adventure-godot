extends "res://scenes/enemies/bullet factory.gd"

func _ready():
	shoot_towards = "outward";
	shoot_angle = -90;
	
	bullet = preload("res://scenes/enemies/foot/skateboard.tscn");
	shoot_delay = 7.0/13.0;
	
	shotgun_bullets = 3;
	shotgun_angle = 20;
	
	._ready();
	
func _initial_angle():
	return get_parent().rotation.y;