extends Control

onready var root = get_tree().get_root();
onready var main = root.get_node("main");
onready var player = main.get_node("player");
onready var inventory = main.get_node("inventory");
var _equipment;
var _item;

func init(equipment):
	_equipment = equipment;
	get_node("rectangle").texture = get_node("viewport").get_texture();
	var item = equipment.get_equipment().instance();
	item.translation -= item.get_node("equip point").translation;
	get_node("viewport").add_child(item);
	_item = item;
	
var was_pressed = false;
	
func _physics_process(delta):
	var pressed = Input.is_mouse_button_pressed(1);
	
	if get_node("rectangle").get_global_rect().has_point(get_viewport().get_mouse_position()):
		_item.rotation.y += PI/4 * delta;
		
		if inventory.can_click:
			if pressed and !was_pressed:
				player.equip(_equipment);
				inventory.reset();
		
	was_pressed = pressed;
	
func reset():
	_item.rotation.y = 0;