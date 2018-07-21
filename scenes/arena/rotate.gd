extends Spatial

var moving = false;
# set by arena (parent)
var direction = 0;
var time = 3;
var previous_time_remaining = 0;
var time_remaining = 0;

const e = 2.71828;

func rotate_90():
	moving = true;
	direction = get_parent().direction * (-1 if (get_name() == "Right") else 1);
	time_remaining = time;

func get_move(t):
	return ((-0.5) * cos(PI * t)) + (0.5);

func _physics_process(delta):
	if not moving:
		return;
	
	previous_time_remaining = time_remaining;
	time_remaining = max(0, time_remaining - delta);
	
#	rotation.z += direction * (get_move(time_remaining / time) - get_move(previous_time_remaining / time)) * PI/2;
	rotate_z(direction * (get_move(time_remaining / time) - get_move(previous_time_remaining / time)) * PI/2);
	
	if time_remaining == 0:
		moving = false;
		
		for side in ["Top", "Right", "Bottom", "Left"]:
			get_node(side).get_node("Platform").extend();
