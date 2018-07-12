extends ColorRect

onready var main = get_tree().get_root().get_node("Main");

func _process(delta):
	if main.has_node("Player"):
		var player = main.get_node("Player");
		rect_size.y = 400.0 * player.health / player.max_health;
	