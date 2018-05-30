extends Spatial

# 1 = extend, -1 = retract, 0 = not moving
var direction = 0;
var time = 1.5;
var time_remaining = 0;

onready var timer = get_node("Timer");
	
func retract():
	direction = -1;
	time_remaining = time;
	pass;
	
func extend():
	direction = 1;
	time_remaining = time;
	pass;

func _physics_process(delta):
	if direction == 0:
		return;
	
	time_remaining = max(0, time_remaining - delta);
	
	transform.origin.z = (-4 + (direction * 4)) + (-direction * (8 * (time_remaining / time)));
	
	if time_remaining == 0:
		# only after retracting
		if direction == -1:
			get_parent().get_parent().rotate_90();

		direction = 0;
	
	pass;
