extends Label

var sounds = ["scronch", "scromble"];

var lifespan = 1;

func _ready():
	if rand_range(0, 100) > 99:
		text = "no don't touch that";
	else:
		text = sounds[randi() % sounds.size()];

var time = 0;

func _physics_process(delta):
	time += delta;
	set_global_position(get_global_position() - Vector2(0, 30 * delta));
	
	if time > lifespan:
		queue_free();