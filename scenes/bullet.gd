extends Spatial

var time_existed = 0;
var lifespan; # -1 means continue until hitting player, -2 means never die (e.g. contact damage)
var damage;
var speed;

onready var area = get_node("Area");

func _physics_process(delta):
	time_existed += delta;
	
	if (time_existed > lifespan and lifespan > 0) or (lifespan <= 0 and time_existed > 100): # hardcoded value of 100 to ensure persistent bullets don't last forever
		queue_free();
	
	var collider = _get_collider();
	if collider != null:
		_damage_collider(collider);
		if lifespan != -2:
			queue_free();
	
	if speed != 0:
		var multiplier = speed * delta / 20;
		transform.origin.x += cos(rotation.y) * multiplier;
		transform.origin.z += -sin(rotation.y) * multiplier;
		
# can be overwritten to do something extra when player collides with bullets
# for example, smol sticks saying "scronch", "scromble", etc. when colliding with player
func _damage_collider(collider):
	collider.damage(damage);
				
func _get_collider():
	pass;
	