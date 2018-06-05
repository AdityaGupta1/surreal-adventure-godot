extends ColorRect

onready var player = get_tree().get_root().get_node("Main").get_node("Player");

func _process(delta):
	rect_size.y = 400.0 * player.health / player.max_health;
