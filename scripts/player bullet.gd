extends KinematicBody

var time_existed = 0;
var lifespan = 3;
var speed = 400;
var damage = 25;

func _physics_process(delta):
	time_existed += delta;
	
	if time_existed > lifespan:
		queue_free();
		
	var collision = move_and_collide(Vector3(cos(rotation.y), 0, -sin(rotation.y)) * speed / 1000);
	
	if collision:
		var hit = collision.get_collider();
		if hit.is_in_group("Enemies"):
			hit.damage(damage);
			queue_free();
		
	pass
