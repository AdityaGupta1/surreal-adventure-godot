extends Spatial

var time_existed = 0;
var lifespan = 3;

var speed = 20;

func _physics_process(delta):
	time_existed += delta;
	
	if time_existed > lifespan:
		queue_free();
		
	move_and_slide(Vector3(cos(rotation.y), 0, -sin(rotation.y)) * speed, Vector3(0, 1, 0));
		
	pass
