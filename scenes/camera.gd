extends Camera

onready var origin = get_camera_transform().origin;
var translate;
var zooming = false;
const zoom_time = 2;
var zoom_end = 0;

func death_zoom(position):
	translate = position - origin;
	zoom_end = time + zoom_time;
	zooming = true;
	
var time = 0;
	
func _physics_process(delta):
	time += delta;
	
	if zooming:
		if time > zoom_end and zoom_end != 0:
			get_tree().reload_current_scene();
		
		get_parent().translate((delta / zoom_time) * translate);