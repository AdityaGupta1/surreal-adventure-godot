extends "res://scripts/character.gd"

var bullet;
var time = shoot_delay;

var shotgun_bullets = 1;
var shotgun_angle = 0;

func _ready():
	add_to_group("Enemies");
	._ready();
	
	pass;
	
func get_shoot_delay():
	return shoot_delay;

func shoot():
	var center_angle = -get_viewport().get_camera().unproject_position(transform.origin).angle_to_point(get_viewport().get_camera().unproject_position(get_tree().get_root().get_node("Main").get_node("Player").transform.origin));
	var initial_angle = center_angle - (((float(shotgun_bullets) / 2) - 0.5) * deg2rad(shotgun_angle));
	
	for i in range(0, shotgun_bullets):
		var new_bullet = bullet.instance();
		new_bullet.transform.origin = global_transform.origin;
		new_bullet.rotation.y = initial_angle + (i * deg2rad(shotgun_angle));
		get_tree().get_root().get_node("Main").add_child(new_bullet);
		
	time = 0;
	
	pass;

func _physics_process(delta):
	if time < shoot_delay: 
		time += delta;
	else:
		shoot();
	
	pass;
