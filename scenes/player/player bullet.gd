extends "res://scenes/bullet.gd"

var base_speed = 400;
var base_damage = 25;

onready var player = get_tree().get_root().get_node("main/player");

func _ready():
	lifespan = 3;
	
	speed = base_speed;
	damage = base_damage * (1 + player.stats()["attack"] / 25);
	print(damage);

func _get_collider():
	for body in area.get_overlapping_bodies():
		if body.is_in_group("enemies"):
			return body;
			
	return null;