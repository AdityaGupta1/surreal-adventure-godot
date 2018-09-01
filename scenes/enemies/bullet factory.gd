extends Node

onready var main = get_tree().get_root().get_node("Main");

var based_on_rotation = true;
var shoot_angle;

var total_time = 0;

var bullet;
var last_shot = 0;

var shotgun_bullets = 1;
var shotgun_angle = 0;

var enemy;

func _ready():
	enemy = get_parent();
	
	while enemy.get_class() != "special enemy":
		enemy = enemy.get_parent();

# should be extended and changed to work with phases
func enemy_process(delta, phase):
	total_time += delta;
	
	if total_time - last_shot >= shoot_delay: 
		_shoot();
		last_shot = total_time;
		
func _shoot():
	if bullet == null:
		return;
	
	var initial_angle = (enemy.get_rotation() if based_on_rotation else shoot_angle) - (((float(shotgun_bullets) / 2) - 0.5) * deg2rad(shotgun_angle));
	
	for i in range(0, shotgun_bullets):
		var new_bullet = bullet.instance();
		new_bullet.transform.origin = global_transform.origin;
		new_bullet.rotation.y = initial_angle + (i * deg2rad(shotgun_angle));
		main.add_child(new_bullet);