extends KinematicBody

var bullet = preload("res://scenes/enemies/conke bottle.tscn");
var shoot_delay = 1;
var time = shoot_delay;

var max_health = 100;
var health = max_health;

func damage(damage):
	health -= damage;
	
	if health <= 0:
		queue_free();
		
	pass;

func _ready():
	add_to_group("Enemies");

func get_shoot_delay():
	return shoot_delay;

func shoot():
	var a = -get_viewport().get_camera().unproject_position(transform.origin).angle_to_point(get_viewport().get_camera().unproject_position(get_tree().get_root().get_node("Main").get_node("Player").transform.origin));
	
	for angle in [a - deg2rad(10), a, a + deg2rad(10)]:
		var new_bullet = bullet.instance();
		new_bullet.transform.origin = global_transform.origin;
		new_bullet.rotation.y = angle;
		get_tree().get_root().get_node("Main").add_child(new_bullet);
		
	time = 0;
	
	pass;

func _physics_process(delta):
	if time < shoot_delay: 
		time += delta;
	else:
		shoot();
	
	pass;
