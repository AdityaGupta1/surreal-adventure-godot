extends TextureRect

var clicked = false;
var muted = false;

func _physics_process(delta):
	if not get_parent().is_visible():
		return;
	
	if Input.is_mouse_button_pressed(1):
		if get_rect().has_point(get_viewport().get_mouse_position()):
			if not clicked:
				clicked = true;
				_on_clicked();
	else:
		clicked = false;
		
onready var other_icon = get_parent().get_node("unmuted");

func _on_clicked():
	muted = !muted;
	if muted:
		self.show();
		other_icon.hide();
	else:
		self.hide();
		other_icon.show();
		
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), muted);