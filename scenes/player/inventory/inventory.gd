extends Spatial

var _show = false;

onready var main = get_parent();
var player;
onready var inventory = get_node("inventory");
onready var vbox = inventory.get_node("items/vbox");
onready var viewport = get_node("viewport");

var current_shape;

var can_click = false;
var time = 0;
var click_time = 0.5;

func _process(delta):
	time += delta;
	
	if time > click_time:
		can_click = true;
	
	if player == null and main.has_node("player"):
		player = get_tree().get_root().get_node("main/player");
		_init_all();
	
	if Input.is_action_just_pressed("ui_inventory"):
		toggle();
		
	if current_shape != null:
		current_shape.rotation.y += PI/4 * delta;

func _init_all():
	_init_player();
	_init_items();
	
func reset():
	if player == null:
		return;
		
	can_click = false;
	time = 0;
	
	current_shape.queue_free();
	current_shape = null;
		
	for child in vbox.get_children():
		child.queue_free();
		
	_init_all();
	
func _init_player():
	inventory.get_node("viewport").texture = viewport.get_texture();
	var shape = player.get_node("shape").duplicate();
	shape.rotation = Vector3(-PI/2, PI/2, PI);
	viewport.add_child(shape);
	current_shape = shape;
	
func _init_items():
	var inventory = player.inventory;
	for item_type in inventory.keys():
		var bar = load("res://scenes/player/inventory/inventory bar.tscn").instance();
		bar.init(item_type, inventory[item_type]);
		vbox.add_child(bar);

func toggle():
	if get_tree().paused and !_show:
		return;
	
	if get_parent().has_node("title screen"):
		return;
		
	_show = !_show;
	
	get_tree().paused = _show;
	
	if _show:
		inventory.show();
		current_shape.rotation.y = PI/2;
		for bar in vbox.get_children():
			bar.reset();
	else:
		inventory.hide();
		
func escape():
	if _show:
		toggle();