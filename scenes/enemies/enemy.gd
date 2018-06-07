extends "res://scripts/character.gd"

signal enemy_died;
var added_signal = false;

onready var main = get_tree().get_root().get_node("Main");

var bullet;
var time = shoot_delay;

var shotgun_bullets = 1;
var shotgun_angle = 0;

var monet = 0;
const monet_disc = preload("res://scenes/monet disc.tscn");

func _ready():
	if not added_signal:
		connect("enemy_died", main, "enemy_died");
		added_signal = true;
	
	add_to_group("enemies");
	._ready();

func _shoot():
	if bullet == null:
		return;
	
	var center_angle = -get_viewport().get_camera().unproject_position(transform.origin).angle_to_point(get_viewport().get_camera().unproject_position(main.get_node("Player").transform.origin));
	var initial_angle = center_angle - (((float(shotgun_bullets) / 2) - 0.5) * deg2rad(shotgun_angle));
	
	for i in range(0, shotgun_bullets):
		var new_bullet = bullet.instance();
		new_bullet.transform.origin = global_transform.origin;
		new_bullet.rotation.y = initial_angle + (i * deg2rad(shotgun_angle));
		main.add_child(new_bullet);
		
	time = 0;

func _physics_process(delta):
	if time < shoot_delay: 
		time += delta;
	else:
		_shoot();
	
func _random_vector(bound):
	return Vector3(rand_range(-bound, bound), rand_range(-bound, bound), rand_range(-bound, bound));

func _die():
	for i in range(monet):
		var new_monet_disc = monet_disc.instance();
		
		var position = global_transform.origin;
		position.x += rand_range(0, 1);
		position.y += 1;
		position.z += rand_range(0, 1);
		new_monet_disc.transform.origin = position;
		
		new_monet_disc.apply_impulse(position + _random_vector(0.1), _random_vector(0.02));
		
		new_monet_disc.rotation.x = rand_range(0, 2 * PI);
		new_monet_disc.rotation.y = rand_range(0, 2 * PI);
		new_monet_disc.rotation.z = rand_range(0, 2 * PI);
		
		main.add_child(new_monet_disc);
	
	emit_signal("enemy_died");
	
	queue_free();