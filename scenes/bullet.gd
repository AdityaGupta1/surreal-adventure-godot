extends "res://scenes/projectile.gd"

var speed;

onready var area = get_node("Area");

func _physics_process(delta):
	var multiplier = speed * delta / 20;
	transform.origin.x += cos(rotation.y) * multiplier;
	transform.origin.z += -sin(rotation.y) * multiplier;
	
	._physics_process(delta);
				
func _get_collider():
	pass;