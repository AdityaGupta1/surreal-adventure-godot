extends RigidBody

func _on_body_entered(body):
	if body.get_name() == "player":
		get_tree().get_root().get_node("main/player").add_monet(1);
		queue_free();
	
func _physics_process(delta):
	if global_transform.origin.y < 0:
		queue_free();