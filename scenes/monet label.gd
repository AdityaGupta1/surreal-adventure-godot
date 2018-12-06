extends Label

func update():
	text = str(get_tree().get_root().get_node("main").get_node("Player").monet);