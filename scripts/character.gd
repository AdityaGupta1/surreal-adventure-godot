extends KinematicBody

var max_health = 100;
var health;
var invulnerable = false;

var shoot_delay = 0;

const monet_disc = preload("res://scenes/monet disc.tscn");

func _ready():
	health = max_health;

func damage(damage):
	health -= damage;
	
	if health <= 0:
		die();
		
	pass;

func die():
	queue_free();