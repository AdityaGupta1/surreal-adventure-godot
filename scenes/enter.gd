extends TextureRect

var clicked = false;

onready var main = get_parent().get_parent();

const player = preload("res://scenes/player/player.tscn");

var time = 0;

func _physics_process(delta):
	time += delta;

	if Input.is_mouse_button_pressed(1) and get_rect().has_point(get_viewport().get_mouse_position()):
		if not clicked:
			clicked = true;
			_on_clicked();

func _on_clicked():
	randomize();

	main.get_node("HUD").show();
	
	var new_player = player.instance();
	new_player.transform.origin.y = 49; # y values of 50 and above crash for some reason (see issue #46)
	main.add_child(new_player);

	main.get_node("arena").start();
	get_parent().queue_free();