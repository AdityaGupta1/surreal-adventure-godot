extends KinematicBody

const e = 2.71828182846;

var speed = 1000;
var jump_velocity = 15;
var gravity = -30;

var direction = Vector3();
var velocity = Vector3();

var up = Vector3(0, 1, 0);

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	direction = Vector3();
	direction.z -= 1 if Input.is_key_pressed(KEY_W) else 0;
	direction.x -= 1 if Input.is_key_pressed(KEY_A) else 0;
	direction.z += 1 if Input.is_key_pressed(KEY_S) else 0;
	direction.x += 1 if Input.is_key_pressed(KEY_D) else 0;
	direction = direction.normalized() * speed * delta;
	
	velocity.y += gravity * delta;
	velocity.x = direction.x;
	velocity.z = direction.z;
	
	velocity = move_and_slide(velocity, up);
	
	# point toward mouse
	rotation.y = -get_viewport().get_camera().unproject_position(transform.origin).angle_to_point(get_viewport().get_mouse_position()) + 135;
	
	if is_on_floor() and Input.is_key_pressed(KEY_SPACE):
		velocity.y += jump_velocity;
	
	pass
