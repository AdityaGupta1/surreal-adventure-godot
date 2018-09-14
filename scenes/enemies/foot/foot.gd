extends "res://scenes/enemies/special enemy.gd"

var offset;

func _ready():
	max_health = 500;
	shoot_delay = 1;
	
	monet = 25;
	
	levitates = true;
	levitate_y = 22.5;
	
	offset = randf() * 2 * PI;
	
	._ready();
	
const planet_orbit_size = 14;
const planet_orbit_frequency = 0.4;
const moon_orbit_size = 3;
const moon_orbit_frequency = 1.9;
	
func _move(delta):
	var t = total_time;
	global_transform.origin.x = planet_orbit_size * cos(planet_orbit_frequency * t + offset) + moon_orbit_size * cos(moon_orbit_frequency * t + offset);
	global_transform.origin.z = planet_orbit_size * sin(planet_orbit_frequency * t + offset) + moon_orbit_size * sin(moon_orbit_frequency * t + offset);
	
	rotation.y = t * PI;
	
func _get_rotation():
	return rotation.y;