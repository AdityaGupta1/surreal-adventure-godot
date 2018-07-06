extends MeshInstance

func _physics_process(delta):
	rotation.y += 0.3 * delta;