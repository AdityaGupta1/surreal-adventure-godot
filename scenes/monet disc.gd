extends RigidBody

func _body_entered(body):
	if body.get_name() == "Player":
		get_tree().get_root().get_node("Main").get_node("Player").monet += 1;
		queue_free();