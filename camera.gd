extends Camera

var initial_rotation;

func _ready():
	initial_rotation = rotation;
	pass

func _process(delta):
	rotation = initial_rotation;
	pass
