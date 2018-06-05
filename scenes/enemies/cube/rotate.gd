extends CollisionShape

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var time = rand_range(0, 10);

func _get_color_value(p):
	return 0.25 + (0.5 * abs(sin(p)));
	
func _get_color():
	return Color(_get_color_value(time), _get_color_value(3 * time), _get_color_value(9 * time));

func _physics_process(delta):
	time += delta;
	rotate_x(delta);
	rotate_y(sin(time) * delta);
	rotate_z(delta);
	
	get_node("MeshInstance").get_surface_material(0).albedo_color = _get_color();
