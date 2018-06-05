extends KinematicBody

var max_health = 100;
var health;
var invulnerable = false;

var shoot_delay = 0;

func _ready():
	health = max_health;
	
func _physics_process(delta):
	if transform.origin.y < 10:
		_die();

func damage(damage):
	health -= damage;
	
	if health <= 0:
		_die();

func _die():
	queue_free();