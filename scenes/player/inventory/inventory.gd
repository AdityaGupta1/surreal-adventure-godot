extends Control

var _show = false;

onready var main = get_parent();
var player;

func _process(delta):
	if player == null and main.has_node("player"):
		player = get_tree().get_root().get_node("main/player");
		init();
	
	if Input.is_action_just_pressed("ui_inventory"):
		toggle();
		
onready var vbox = get_node("items/vbox");
		
func init():
	var inventory = player.inventory;
	for item_type in inventory.keys():
		var control = Control.new();
		var bar = load("res://scenes/player/inventory/inventory bar.tscn").instance();
		bar.init(item_type, null);
		control.add_child(bar);
		vbox.add_child(control);

func toggle():
	if get_tree().paused and !_show:
		return;
		
	_show = !_show;
	
	get_tree().paused = _show;
	
	if _show:
		show();
	else:
		hide();
		
func escape():
	if _show:
		toggle();