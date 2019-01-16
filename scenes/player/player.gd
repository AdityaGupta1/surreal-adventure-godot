extends "res://scenes/character.gd"

onready var main = get_parent();

const e = 2.71828182846;

var speed = 600;
var jump_velocity = 15;
var can_move = true;
var gravity = -30;

var direction = Vector3();
var velocity = Vector3();

var up = Vector3(0, 1, 0);

var can_shoot = true;
var last_shot = 0.92;
var next_gun = 1;

var monet = 0;

var vulnerable = 0;

onready var sounds = get_node("sounds");

onready var equipment_manager = preload("res://scenes/player/equipment/equipment manager.gd").new();

var current_equipment = {};
var inventory = {};

func _ready():
	max_health = 500;
	shoot_delay = get_node("shape/guns/gun 1").get_shoot_delay();
	_equip(equipment_manager.get_equipment("hat", "bottlecap"));
	_equip(equipment_manager.get_equipment("hat", "fedora"));
	._ready();

func damage(damage):
	if vulnerable > total_time:
		return;

	var hurt_sounds = sounds.get_node("hurt");
	hurt_sounds.get_children()[randi() % hurt_sounds.get_child_count()].play();

	.damage(damage);

	vulnerable = total_time + 0.5;
	
func heal(health_restored):
	health = min(health + health_restored, max_health);
	
# offset by which movement is rotated (used when changing camera angles)
# set in degrees by using set_movement_offset
var _movement_offset = 0; 
var _next_movement_offset = 0; # used so the movement offset doesn't change until a certain time after a change in camera angle
var _change_movement_offset_time = 0;

func set_movement_offset(offset):
	_next_movement_offset = deg2rad(offset);
	_change_movement_offset_time = total_time + 0.2;
	
# mouse, with heading
var rotation_mode = "mouse";
var last_rotation = 0;
	
var _in_shop = false;

func _physics_process(delta):
	if _dead:
		return;
	
	total_time += delta;

	direction = Vector2();
	direction.y += (1 if Input.is_key_pressed(KEY_W) else 0) - (1 if Input.is_key_pressed(KEY_S) else 0);
	direction.x += (1 if Input.is_key_pressed(KEY_A) else 0) - (1 if Input.is_key_pressed(KEY_D) else 0);
	
	if total_time > _change_movement_offset_time and _movement_offset != _next_movement_offset:
		_movement_offset = _next_movement_offset;
		
	direction = direction.rotated(_movement_offset);

	direction = direction.normalized() * speed * delta;
	direction *= 1 if is_on_floor() else 0.8; # slower movement in the air

	velocity.y += gravity * delta;
	velocity.x = direction.x;
	velocity.z = direction.y;

	if is_on_floor() and Input.is_key_pressed(KEY_SPACE) and can_move:
		velocity.y += jump_velocity;

	if not can_move:
		velocity.x = 0;
		velocity.z = 0;

	velocity = move_and_slide(velocity, up);

	if rotation_mode == "mouse":
		rotation.y = -get_viewport().get_camera().unproject_position(transform.origin).angle_to_point(get_viewport().get_mouse_position());
	elif rotation_mode == "with heading":
		if direction.length() == 0:
			rotation.y = last_rotation;
		else:
			rotation.y = -direction.angle();
		
	last_rotation = rotation.y;

	if can_shoot and total_time - last_shot >= shoot_delay and Input.is_mouse_button_pressed(1):
		last_shot = total_time;
		get_node("shape/guns/gun " + str(next_gun)).shoot();
		next_gun = 2 if next_gun == 1 else 1;
		shoot_delay = get_node("shape/guns/gun " + str(next_gun)).get_shoot_delay();
		
	if global_transform.origin.z > 20 and not _in_shop:
		get_viewport().get_camera().go_point("shop start");
		_in_shop = true;
		rotation_mode = "with heading";
	elif global_transform.origin.z < 20 and _in_shop:
		get_viewport().get_camera().go_point("origin");
		_in_shop = false;
		rotation_mode = "mouse";
	
	can_shoot = !_in_shop;

func add_monet(new_monet):
	monet += new_monet;
	sounds.get_node("collect monet disc").play();
	main.get_node("HUD/monet label").update();

func lock_movement():
	can_move = false;

func unlock_movement():
	can_move = true;
	
func _die():
	_dead = true;
	rotation.x -= PI / 2;
	rotation.z += PI / 2;
	get_viewport().get_camera().zoom_position(get_node("shape/meme man/eye " + str((randi() % 2) + 1)).global_transform.origin, 2);
	
func _equip(equipment):
	var item = equipment.get_equipment().instance();
	item.translation = -item.get_node("equip point").translation;
	
	var item_type = equipment.item_type;
	if current_equipment.has(item_type):
		var previous_equipment = current_equipment[item_type];
		inventory[item_type].append(previous_equipment);
	current_equipment[item_type] = equipment;
	if !inventory.has(item_type):
		inventory[item_type] = [];
	inventory[item_type].erase(equipment);
	
	print(current_equipment);
	print(inventory);
	
	var equipment_node = get_node("equipment").get_node(equipment.item_type);
	for i in range(0, equipment_node.get_child_count()):
	    equipment_node.get_child(i).queue_free()
	equipment_node.add_child(item);
	
func finished_zoom():
	if _dead:
		get_tree().reload_current_scene();