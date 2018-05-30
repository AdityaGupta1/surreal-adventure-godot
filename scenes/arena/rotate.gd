extends Spatial

var moving = false;
var time = 1;
var previous_time_remaining = 0;
var time_remaining = 0;

func rotate():
	moving = true;
	time_remaining = time;

func _physics_process(delta):
	if not moving:
		return;
	
	previous_time_remaining = time_remaining;
	time_remaining = max(0, time_remaining - delta);
	
	rotation.z += ((previous_time_remaining - time_remaining) / time) * PI/2;
	
	if time_remaining == 0:
		moving = false;
		
		for side in ["Top", "Right", "Bottom", "Left"]:
			get_node(side).get_node("Platform").extend();
	
	pass;
