extends Spatial

var time_existed = 0;
var lifespan; # -1 means continue until hitting player, -2 means never die (e.g. contact damage)
var damage;
var speed;

onready var area = get_node("Area");

func _physics_process(delta):
	time_existed += delta;
	
	if time_existed > lifespan and lifespan > 0:
		queue_free();
	
	var collider = _get_collider();
	if collider != null:
		collider.damage(damage);
		if lifespan != -2:
			queue_free();
	
	if speed != 0:
		var multiplier = speed * delta / 20;
		transform.origin.x += cos(rotation.y) * multiplier;
		transform.origin.z += -sin(rotation.y) * multiplier;
				
func _get_collider():
	pass;
	