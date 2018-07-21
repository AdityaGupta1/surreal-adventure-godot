extends Camera

onready var origin = get_parent().global_transform.origin;
var zoom_position;
var zooming = false;
const zoom_time = 2;
var zoom_end = 0;

func death_zoom(position):
	zoom_position = position;
	zoom_end = time + zoom_time;
	zooming = true;
	
	print(position);
	print(origin);
	
var time = 0;
	
func _physics_process(delta):
	time += delta;
	
	if zooming:
		if time > zoom_end and zoom_end != 0:
			get_tree().reload_current_scene();
		
		translate((delta / zoom_time) * (zoom_position - origin));