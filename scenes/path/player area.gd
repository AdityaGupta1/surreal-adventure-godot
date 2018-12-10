extends Area

onready var camera = get_parent().get_node("camera");
onready var main_camera = get_tree().get_root().get_node("main").get_node("camera");

func _on_body_entered(body):
	if body.get_name() != "Player":
		return;
		
	camera.make_current();
	body.set_movement_offset(-sign(global_transform.origin.x) * 90);

func _on_body_exited(body):
	if body.get_name() != "Player":
		return;
		
	main_camera.make_current();
	body.set_movement_offset(0);
