extends RigidBody

func _on_body_entered(body):
	if body.get_name() == "Player":
		get_tree().get_root().get_node("main").get_node("Player").add_monet(1);
		queue_free();
	
func _physics_process(delta):
	if global_transform.origin.y < 0:
		queue_free();