extends Spatial

var _show = false;

onready var main = get_parent();
var player;
onready var inventory = get_node("inventory");
onready var viewport = get_node("viewport");

var current_shape;

func _process(delta):
	if player == null and main.has_node("player"):
		player = get_tree().get_root().get_node("main/player");
		_init_player();
		_init_items();
	
	if Input.is_action_just_pressed("ui_inventory"):
		toggle();
		
	if current_shape != null:
		current_shape.rotation.y += PI/4 * delta;
		
onready var vbox = inventory.get_node("items/vbox");
	
func _init_player():
	inventory.get_node("viewport").texture = viewport.get_texture();
	var shape = player.get_node("shape").duplicate();
	shape.rotation = Vector3(-PI/2, PI/2, PI);
	viewport.add_child(shape);
	current_shape = shape;
	pass;
	
func _init_items():
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
	
	if get_parent().has_node("title screen"):
		return;
		
	_show = !_show;
	
	get_tree().paused = _show;
	
	if _show:
		inventory.show();
	else:
		inventory.hide();
		
func escape():
	if _show:
		toggle();