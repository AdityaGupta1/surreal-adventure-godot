extends "res://scripts/character.gd"

const e = 2.71828182846;

var current_time = 0;

var speed = 600;
var jump_velocity = 15;
var gravity = -30;

var direction = Vector3();
var velocity = Vector3();

var up = Vector3(0, 1, 0);

var last_shot = 0;
var next_gun = 1;

var monet = 0;

func _ready():
	max_health = 200;
	invulnerable = true;
	shoot_delay = get_node("Guns/Gun1").get_shoot_delay();
	._ready();
	
	pass;

func _physics_process(delta):
	current_time += delta;
	
	if is_on_floor():
		direction = Vector3();
		direction.z += (1 if Input.is_key_pressed(KEY_W) else 0) - (1 if Input.is_key_pressed(KEY_S) else 0);
		direction.x += (1 if Input.is_key_pressed(KEY_A) else 0) - (1 if Input.is_key_pressed(KEY_D) else 0);
		
	direction = direction.normalized() * speed * delta;
	
	velocity.y += gravity * delta;
	velocity.x = direction.x;
	velocity.z = direction.z;
	
	velocity = move_and_slide(velocity, up);
	
	# point toward mouse
	rotation.y = -get_viewport().get_camera().unproject_position(transform.origin).angle_to_point(get_viewport().get_mouse_position());
	
	if is_on_floor() and Input.is_key_pressed(KEY_SPACE):
		velocity.y += jump_velocity;
	
	if current_time - last_shot > shoot_delay and Input.is_mouse_button_pressed(1):
		last_shot = current_time;
		get_node("Guns/Gun" + str(next_gun)).shoot();
		next_gun = 2 if next_gun == 1 else 1;
		shoot_delay = get_node("Guns/Gun" + str(next_gun)).get_shoot_delay();
	
	pass;