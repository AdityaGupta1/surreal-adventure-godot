extends Control

var paused;

func _process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		_toggle_paused();

func _toggle_paused():
	paused = !paused;
	
	get_tree().paused = paused;
	
	if paused:
		show();
	else:
		hide();