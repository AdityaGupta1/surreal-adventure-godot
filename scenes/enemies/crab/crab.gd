extends "res://scenes/enemies/enemy.gd"

func _ready():
	max_health = 150;
	
	bullet = null;
	
	monet = 4;
	
	._ready();
	
func _move(delta):
	transform.origin.x += (player.transform.origin.x - transform.origin.x) / 2 * delta;
	transform.origin.z += (player.transform.origin.z - transform.origin.z) / 2 * delta;
	rotation.y = -get_viewport().get_camera().unproject_position(transform.origin).angle_to_point(get_viewport().get_camera().unproject_position(player.transform.origin)) + PI;