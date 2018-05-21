extends KinematicBody

var max_health = 100;
var health;
var invulnerable = false;

var shoot_delay = 0;

func _ready():
	health = max_health;

func damage(damage):
	health -= damage;
	
	if health <= 0:
		_die();
		
	pass;

func _die():
	queue_free();