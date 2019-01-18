extends Control

func init(item_type, items):
	get_node("item type").text = item_type;
	
	var item_viewer = load("res://scenes/player/inventory/item viewer.tscn");
	
	for item in items:
		var control = Control.new();
		var new_item_viewer = item_viewer.instance();
		new_item_viewer.init(item);
		control.add_child(new_item_viewer);
		get_node("inventory bar/hbox").add_child(control);