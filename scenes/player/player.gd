extends "res://scenes/character.gd"

const e = 2.71828182846;

var total_time = 0;

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

func _ready():
#	max_health = 500;
	max_health = 1;
	shoot_delay = get_node("guns/gun 1").get_shoot_delay();
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
		get_node("guns/gun " + str(next_gun)).shoot();
		next_gun = 2 if next_gun == 1 else 1;
		shoot_delay = get_node("guns/gun " + str(next_gun)).get_shoot_delay();

func add_monet(new_monet):
	monet += new_monet;
	sounds.get_node("collect monet disc").play();
	get_tree().get_root().get_node("Main").get_node("HUD").get_node("monet label").update();

func lock_movement():
	can_move = false;

func unlock_movement():
	can_move = true;
	
func _set_eye_scale(scale):
	for i in range(2):
		get_node("meme man/eye " + str(i + 1)).scale = Vector3(scale, scale, scale)
	
func _die():
	_dead = true;
	_set_eye_scale(1.4);
	rotation.x -= PI / 2;
	rotation.z += PI / 2;
	get_viewport().get_camera().death_zoom(get_node("meme man/eye " + str((randi() % 2) + 1)).global_transform.origin);
	
