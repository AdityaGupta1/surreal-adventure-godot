extends Spatial

var time_existed = 0;
var lifespan; # -1 means continue until hitting player, -2 means never die (e.g. contact damage)
var damage;

func _physics_process(delta):
	time_existed += delta;
	
	if time_existed > lifespan and lifespan != -1:
		queue_free();
	
	var collider = _get_collider();
	if collider != null:
		collider.damage(damage);
		if lifespan != -2:
			queue_free();
				
func _get_collider():
	pass;