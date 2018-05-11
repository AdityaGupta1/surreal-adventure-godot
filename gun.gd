extends Spatial

var shoot_delay = 0.5;
var rotation_time = (0.8 * shoot_delay)
var a = 2.2475 / rotation_time;

var total_time = rotation_time;

func get_shoot_delay():
	return shoot_delay;

func shoot():
	total_time = 0;
	pass;

func _get_rotation(x):
	return max((50 / 2.1564) * (-pow((a * x) - pow(3, 1/4), 4) + 3 - (a * x)), 0);

func _physics_process(delta):
	if total_time < rotation_time: 
		total_time += delta;
		print(total_time);
		print(_get_rotation(total_time));
	
	rotation.z = deg2rad(_get_rotation(total_time));
	
	pass;
