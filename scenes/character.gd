extends KinematicBody

var max_health = 100;
var health;
var invulnerable = false;

var shoot_delay = 0;

var _dead = false;

func _ready():
	health = max_health;
	
func _physics_process(delta):
	if _dead:
		return;
	
	if transform.origin.y < 10:
		_die();

func damage(damage):
	if invulnerable:
		return;
	
	if _dead:
		return;
	
	health -= damage;
	
	if health <= 0:
		_die();

func _die():
	_dead = true;
	queue_free();