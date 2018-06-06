extends Spatial

var time_existed = 0;
var lifespan;
var speed;
var damage;

onready var area = get_node("Area");

func _physics_process(delta):
	time_existed += delta;
	
	if time_existed > lifespan and lifespan != -1:
		queue_free();
		
	var multiplier = speed * delta / 20;
	transform.origin.x += cos(rotation.y) * multiplier;
	transform.origin.z += -sin(rotation.y) * multiplier;
	
	var collider = _get_collider();
	if collider != null:
		collider.damage(damage);
		if lifespan != -1:
			queue_free();
				
func _get_collider():
	pass;