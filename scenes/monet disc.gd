extends RigidBody

func _on_body_entered(body):
	if body.get_name() == "Player":
		get_tree().get_root().get_node("Main").get_node("Player").add_monet(1);
		queue_free();