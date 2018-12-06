extends Spatial

# 1 = extend, -1 = retract, 0 = not moving
var direction = 0;
var time = 1.5;
var time_remaining = 0;
	
func retract():
	direction = -1;
	time_remaining = time;
	
func extend():
	direction = 1;
	time_remaining = time;

func _physics_process(delta):
	if direction == 0:
		return;
	
	time_remaining = max(0, time_remaining - delta);
	
	transform.origin.z = (-4 + (direction * 4)) + (-direction * (8 * (time_remaining / time)));
	
	if time_remaining == 0:
		# only after retracting
		if direction == -1:
			get_parent().get_parent().rotate_90();
		
		# only after extending
		if direction == 1:
			get_tree().get_root().get_node("main").get_node("Player").unlock_movement();
			get_parent().get_parent().get_parent().done_extending();

		direction = 0;
