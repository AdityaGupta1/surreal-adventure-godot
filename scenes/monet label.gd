extends Label

func _process(delta):
	text = str(get_tree().get_root().get_node("Main").get_node("Player").monet);
	pass;