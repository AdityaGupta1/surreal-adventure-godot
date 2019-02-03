extends TextureRect

var _clicked = false;
var _muted = false;

func _ready():
	_set_muted(get_tree().get_root().get_node("main").load_data["muted"]);

func _physics_process(delta):
	if not get_parent().is_visible():
		return;
	
	if Input.is_mouse_button_pressed(1):
		if get_rect().has_point(get_viewport().get_mouse_position()):
			if not _clicked:
				_clicked = true;
				_on_clicked();
	else:
		_clicked = false;

func _get_bus(name):
	return AudioServer.get_bus_index(name);

onready var other_icon = get_parent().get_node("unmuted");

func _set_muted(muted):
	_muted = muted;
	if _muted:
		self.show();
		other_icon.hide();
	else:
		self.hide();
		other_icon.show();
		
	AudioServer.set_bus_mute(_get_bus("Master"), _muted);

func _on_clicked():
	_set_muted(!_muted);
	
func is_muted():
	return _muted;