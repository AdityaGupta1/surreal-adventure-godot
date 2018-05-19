extends MeshInstance

var time = 0;

func _get_color_value(p):
	return 0.25 + (0.5 * abs(sin(p)));
	
func _get_color():
	return Color(_get_color_value(time), _get_color_value(3 * time), _get_color_value(9 * time));

func _physics_process(delta):
	time += delta;
	get_surface_material(0).albedo_color = _get_color();
	
	pass;
