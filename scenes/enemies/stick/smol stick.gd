extends "res://scenes/enemies/enemy bullet.gd"

onready var scronch = preload("scronch.tscn");

func _ready():
	lifespan = 15;
	speed = 0;
	damage = 15;
	
	rotation.x = rand_range(0, 2 * PI);
	rotation.y = rand_range(0, 2 * PI);
	rotation.z = rand_range(0, 2 * PI);
	
func _damage_collider(collider):
	var unprojected_position = get_viewport().get_camera().unproject_position(global_transform.origin);
	var new_scronch = scronch.instance();
	get_tree().get_root().get_node("main").add_child(new_scronch);
	new_scronch.set_global_position(Vector2(unprojected_position.x - (new_scronch.rect_size.x / 2), unprojected_position.y - (2 * new_scronch.rect_size.y)));
	
	._damage_collider(collider);