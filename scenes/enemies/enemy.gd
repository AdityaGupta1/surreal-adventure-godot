extends "res://scenes/character.gd"

signal enemy_died;
var added_signal = false;

onready var main = get_tree().get_root().get_node("Main");
onready var player = main.get_node("Player");

var total_time = 0;

var bullet;
var last_shot = 0;
var shoot_towards = "player"; # player, outward

var shotgun_bullets = 1;
var shotgun_angle = 0;

var monet = 0;
const monet_disc = preload("res://scenes/monet disc.tscn");

var gravity = -30;
var levitates = false;
var levitate_y = 0;

var origin;

func _ready():
	if not added_signal:
		connect("enemy_died", main, "enemy_died");
		added_signal = true;
		
	if levitates:
		transform.origin.y = levitate_y;
	origin = transform.origin;
	
	add_to_group("enemies");
	._ready();
	
func _move(delta):
	pass;

func _shoot():
	if bullet == null:
		return;
	
	var center_angle;
	if shoot_towards == "player":
		center_angle = -get_viewport().get_camera().unproject_position(transform.origin).angle_to_point(get_viewport().get_camera().unproject_position(player.transform.origin));
	elif shoot_towards == "outward":
		center_angle = _initial_angle();
	
	var initial_angle = center_angle - (((float(shotgun_bullets) / 2) - 0.5) * deg2rad(shotgun_angle));
	
	for i in range(0, shotgun_bullets):
		var new_bullet = bullet.instance();
		new_bullet.transform.origin = get_node("bullet origin").global_transform.origin;
		new_bullet.rotation.y = initial_angle + (i * deg2rad(shotgun_angle));
		main.add_child(new_bullet);
		
	last_shot = total_time;

func _physics_process(delta):
	_move(delta);
	
	if not levitates:
		move_and_collide(Vector3(0, gravity * delta, 0));
	
	total_time += delta;
	
	if total_time - last_shot >= shoot_delay: 
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
	
	._die();
	
#should only be used if shoot_towards isn't "player"
func _initial_angle():
	pass;