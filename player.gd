extends KinematicBody

var speed = 400;
var jumpVelocity = 15;
var gravity = -30;

var direction = Vector3();
var velocity = Vector3();

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	direction = Vector3();
	
	if Input.is_key_pressed(KEY_W):
		direction.x += 1;
	if Input.is_key_pressed(KEY_A):
		direction.z -= 1;
	if Input.is_key_pressed(KEY_S):
		direction.x -= 1;
	if Input.is_key_pressed(KEY_D):
		direction.z += 1;
		
	direction = direction.normalized() * speed * delta;
	
	velocity.y += gravity * delta;
	velocity.x = direction.x;
	velocity.z = direction.z;
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0));
	
	if is_on_floor() and Input.is_key_pressed(KEY_SPACE):
		velocity.y += jumpVelocity;
		
	pass
