extends RigidBody

func _ready():
	contact_monitor = true;
	contacts_reported = 100;

	pass;

func _process(delta):
	for body in get_colliding_bodies():
		if body.get_name() == "Player":
			queue_free();
			get_tree().get_root().get_node("Main").get_node("Player").monet += 1;
		
	pass;
