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

var last_shot = 0;
var next_gun = 1;

var monet = 0;

var vulnerable = 0;

onready var sounds = get_node("sounds");

func _ready():
	max_health = 500;
	shoot_delay = get_node("guns/gun 1").get_shoot_delay();
	._ready();

func damage(damage):
	if vulnerable > total_time:
		return;

	var hurt_sounds = sounds.get_node("hurt");
	hurt_sounds.get_children()[randi() % hurt_sounds.get_child_count()].play();

	.damage(damage);

	vulnerable = total_time + 0.5;

func _physics_process(delta):
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
		
	# update eyes with health
	var damage_amount = (max_health - health) / float(max_health)
	var eye_scale = 0.4 * (1 - damage_amount)
	get_node("meme man/eye 1").scale = Vector3(eye_scale, eye_scale, eye_scale)
	get_node("meme man/eye 2").scale = Vector3(eye_scale, eye_scale, eye_scale)

func add_monet(new_monet):
	monet += new_monet;
	sounds.get_node("collect monet disc").play();
	get_tree().get_root().get_node("Main").get_node("HUD").get_node("monet label").update();

func lock_movement():
	can_move = false;

func unlock_movement():
	can_move = true;
