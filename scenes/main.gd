extends Spatial

func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 20);
	pass;

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene();
	pass;