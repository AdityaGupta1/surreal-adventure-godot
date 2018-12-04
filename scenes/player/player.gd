extends "res://scenes/character.gd"

const e = 2.71828182846;

var speed = 600;
var jump_velocity = 15;
var can_move = true;
var gravity = -30;

var direction = Vector3();
var velocity = Vector3();

var up = Vector3(0, 1, 0);

var last_shot = 0.92;
var next_gun = 1;

var monet = 0;

var vulnerable = 0;

onready var sounds = get_node("sounds");

onready var equipment_manager = preload("res://scenes/player/equipment/equipment manager.gd").new();

func _ready():
	max_health = 500;
	shoot_delay = get_node("shape/guns/gun 1").get_shoot_delay();
	var hat = equipment_manager.get_equipment("hat", "bottlecap");
	_equip(hat);
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
	
var in_shop = false;

func _physics_process(delta):
	if _dead:
		return;
	
	total_time += delta;

	direction = Vector3();
	direction.z += (1 if Input.is_key_pressed(KEY_W) else 0) - (1 if Input.is_key_pressed(KEY_S) else 0);
	direction.x += (1 if Input.is_key_pressed(KEY_A) else 0) - (1 if Input.is_key_pressed(KEY_D) else 0);

	direction = direction.normalized() * speed * delta;
	direction *= 1 if is_on_floor() else 0.8;

	velocity.y += gravity * delta;
	velocity.x = direction.x;
	velocity.z = direction.z;

	if is_on_floor() and Input.is_key_pressed(KEY_SPACE) and can_move:
		velocity.y += jump_velocity;

	if not can_move:
		velocity.x = 0;
		velocity.z = 0;

	velocity = move_and_slide(velocity, up);

	# point toward mouse
	rotation.y = -get_viewport().get_camera().unproject_position(transform.origin).angle_to_point(get_viewport().get_mouse_position());

	if total_time - last_shot >= shoot_delay and Input.is_mouse_button_pressed(1):
		last_shot = total_time;
		get_node("shape/guns/gun " + str(next_gun)).shoot();
		next_gun = 2 if next_gun == 1 else 1;
		shoot_delay = get_node("shape/guns/gun " + str(next_gun)).get_shoot_delay();
		
	if global_transform.origin.z > 20 and not in_shop:
		get_viewport().get_camera().zoom_point("shop start", 2);
		in_shop = true;
	elif global_transform.origin.z < 20 and in_shop:
		get_viewport().get_camera().zoom_point("origin", 2);
		in_shop = false;

func add_monet(new_monet):
	monet += new_monet;
	sounds.get_node("collect monet disc").play();
	get_tree().get_root().get_node("Main").get_node("HUD").get_node("monet label").update();

func lock_movement():
	can_move = false;

func unlock_movement():
	can_move = true;
	
func _die():
	_dead = true;
	rotation.x -= PI / 2;
	rotation.z += PI / 2;
	get_viewport().get_camera().zoom_pose(get_node("shape/meme man/eye " + str((randi() % 2) + 1)).global_transform.origin, 2);
	
func _equip(equipment):
	var item = equipment.get_equipment().instance();
	item.translation = -item.get_node("equip point").translation;
	
	var equipment_node = get_node("equipment").get_node(equipment.item_type);
	for i in range(0, equipment_node.get_child_count()):
	    equipment_node.get_child(i).queue_free()
	equipment_node.add_child(item);
	
func finished_zoom():
	if _dead:
		get_tree().reload_current_scene();