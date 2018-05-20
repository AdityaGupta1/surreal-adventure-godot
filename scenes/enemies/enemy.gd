extends "res://scripts/character.gd"

var bullet;
var time = shoot_delay;

var shotgun_bullets = 1;
var shotgun_angle = 0;

var monet = 0;

func _ready():
	add_to_group("Enemies");
	._ready();
	
	pass;

func _shoot():
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
		_shoot();
	
	pass;
	
func _random_vector(bound):
	return Vector3(rand_range(-bound, bound), rand_range(-bound, bound), rand_range(-bound, bound));

func die():
	for i in range(monet):
		var new_monet_disc = monet_disc.instance();
		
		var position = global_transform.origin;
		position.x += rand_range(0, 1);
		position.y += 1;
		position.z += rand_range(0, 1);
		new_monet_disc.transform.origin = position;
		
		new_monet_disc.apply_impulse(position + _random_vector(0.4), _random_vector(0.1));
		
		new_monet_disc.rotation.x = rand_range(0, 2 * PI);
		new_monet_disc.rotation.y = rand_range(0, 2 * PI);
		new_monet_disc.rotation.z = rand_range(0, 2 * PI);
		
		get_tree().get_root().get_node("Main").add_child(new_monet_disc);
		
	.die();