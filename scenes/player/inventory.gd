extends Control

var _show = false;

func _process(delta):
	if Input.is_action_just_pressed("ui_inventory"):
		toggle();

func toggle():
	if get_tree().paused and !_show:
		return;
		
	_show = !_show;
	
	get_tree().paused = _show;
	
	if _show:
		show();
	else:
		hide();
		
func escape():
	if _show:
		toggle();