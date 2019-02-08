extends "res://scenes/character.gd"

signal enemy_died;
var added_signal = false;

onready var main = get_tree().get_root().get_node("main");
onready var player = main.get_node("player");
onready var enemies = main.get_node("enemies");

var bullet;
var last_shot = 0;
var shoot_towards = "player"; # absolute, player, outward
var shoot_angle = 0;

var shotgun_bullets = 1;
var shotgun_angle = 0;

var monet = 0;
const monet_disc = preload("res://scenes/monet disc.tscn");

var gravity = -30;
var levitates = false;
var levitate_y = 0;

var origin;

func _ready():
	add_to_group("enemies");
	
	if not added_signal:
		connect("enemy_died", main, "enemy_died");
		added_signal = true;
		
	if levitates:
		transform.origin.y = levitate_y;
	origin = transform.origin;
	
	._ready();
	
func _move(delta):
	pass;
	
func _has_player():
	return main.has_node("player");

func _shoot():
	if bullet == null:
		return;
	
	var center_angle = 0;
	if shoot_towards == "absolute":
		pass;
	elif shoot_towards == "player":
		center_angle = -get_viewport().get_camera().unproject_position(transform.origin).angle_to_point(get_viewport().get_camera().unproject_position(player.transform.origin));
		var self_pos = self.global_transform.origin;
		var player_pos = player.global_transform.origin;
		center_angle = PI - Vector2(self_pos.x, self_pos.z).angle_to_point(Vector2(player_pos.x, player_pos.z));
	elif shoot_towards == "outward":
		center_angle = _initial_angle();
		
	center_angle += shoot_angle;
	
	var initial_angle = center_angle - (((float(shotgun_bullets) / 2) - 0.5) * deg2rad(shotgun_angle));
	
	for i in range(0, shotgun_bullets):
		var new_bullet = bullet.instance();
		new_bullet.transform.origin = get_node("bullet origin").global_transform.origin;
		new_bullet.rotation.y += initial_angle + (i * deg2rad(shotgun_angle));
		main.add_child(new_bullet);

func _physics_process(delta):
	if !_has_player():
		return;
	
	_move(delta);
	
	if not levitates:
		move_and_collide(Vector3(0, gravity * delta, 0));
	
	total_time += delta;
	
	if total_time - last_shot >= shoot_delay: 
		_shoot();
		last_shot = total_time;
	
func _random_vector(bound):
	return Vector3(rand_range(-bound, bound), rand_range(-bound, bound), rand_range(-bound, bound));

func _die():
	for i in range(monet):
		var new_monet_disc = monet_disc.instance();
		
		var position = global_transform.origin;
		var add_vector = _random_vector(1);
		add_vector.y = 1;
		position += add_vector;
		new_monet_disc.transform.origin = position;
		
		new_monet_disc.apply_impulse(_random_vector(0.1), _random_vector(4));
		
		new_monet_disc.rotation.x = rand_range(0, 2 * PI);
		new_monet_disc.rotation.y = rand_range(0, 2 * PI);
		new_monet_disc.rotation.z = rand_range(0, 2 * PI);
		
		main.add_child(new_monet_disc);
	
	emit_signal("enemy_died");
	
	._die();
	
#should only be used if shoot_towards isn't "player"
func _initial_angle():
	pass;
	
func get_no_spawn_radius():
	return 3;