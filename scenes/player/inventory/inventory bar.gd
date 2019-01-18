extends Control

var hbox;

func init(item_type, items):
	get_node("item type").text = item_type;
	
	var item_viewer = load("res://scenes/player/inventory/item viewer.tscn");
	
	for item in items:
		var new_item_viewer = item_viewer.instance();
		new_item_viewer.init(item);
		hbox = get_node("inventory bar/hbox");
		hbox.add_child(new_item_viewer);
		
func reset():
	for item_viewer in hbox.get_children():
		item_viewer.reset();