extends RigidBody

func _ready():
	set_contact_monitor(true);
	set_max_contacts_reported(100);
	can_sleep = false;

	pass;

func _physics_process(delta):
	if get_tree().get_root().get_node("Main").get_node("Player") in get_colliding_bodies():
		get_tree().get_root().get_node("Main").get_node("Player").monet += 1;
		queue_free();

	pass;