extends Spatial

var shoot_delay = 0.5;
var rotation_time = (0.8 * shoot_delay)
var a = 2.2475 / rotation_time;

var time = rotation_time;

var bullet = preload("res://scenes/player/bullet.tscn");

func get_shoot_delay():
	return shoot_delay;

func shoot():
	var new_bullet = bullet.instance();
	new_bullet.transform.origin = get_node("barrel").global_transform.origin;
	new_bullet.rotation.y = get_tree().get_root().get_node("main/player").rotation.y;
	get_tree().get_root().get_node("main").add_child(new_bullet);
	time = 0;
	
	get_node("sound").play(0);

func _get_rotation(x):
	return max((50 / 2.1564) * (-pow((a * x) - pow(3, 1/4), 4) + 3 - (a * x)), 0);

func _physics_process(delta):
	if time < rotation_time: 
		time += delta;
	
	rotation.z = deg2rad(_get_rotation(time)); 
