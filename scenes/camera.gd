extends Camera

var translate;
var rotate;
var zooming = false;
var zoom_time;
var zoom_end = 0;

# regular rotation seems to be rotating the wrong way
onready var actual_rotation = self.rotation_degrees;

var points = {
	"origin": [Vector3(0, 50, 0), Vector3(-90, 180, 0)],
	"shop start": [Vector3(0, 25, 13), Vector3(-180, 180, 0)]
};

func zoom_pose(to_position, to_rotation, zoom_time):
	translate = to_position - global_transform.origin;
	
	rotate = _fix_vector(to_rotation - actual_rotation);
	
	self.zoom_time = zoom_time;
	zoom_end = time + zoom_time;
	zooming = true;
	
func zoom_position(to_position, zoom_time):
	zoom_pose(to_position, actual_rotation, zoom_time);
	
func zoom_point(point, zoom_time):
	zoom_pose(points[point][0], points[point][1], zoom_time);
	
func go_pose(to_position, to_rotation):
	global_transform.origin = to_position;
	rotate = _fix_vector(to_rotation - actual_rotation) * PI / 180;
	rotate_x(rotate.x);
	rotate_y(rotate.y);
	rotate_z(rotate.z);
	actual_rotation = to_rotation;
	
func go_position(to_position):
	go_pose(to_position, actual_rotation);
	
func go_point(point):
	go_pose(points[point][0], points[point][1]);
	
# makes sure no rotation is greater than 180 degrees
func _fix_vector(vector):
	var values = [vector.x, vector.y, vector.z];

	for i in range(3):
		if abs(values[i]) > 180:
			values[i] = 360 - values[i];
			
			while values[i] > 360:
				values[i] -= 360;

	return Vector3(values[0], values[1], values[2]);
	
	
var time = 0;
	
func _physics_process(delta):
	time += delta;
	
	if zooming:
		if time > zoom_end and zoom_end != 0:
			get_tree().get_root().get_node("Main").get_node("Player").finished_zoom();	
			zooming = false;
			
		var delta_translate = (delta / zoom_time) * translate;
		global_translate(delta_translate);
		
		var delta_rotate = (delta / zoom_time) * rotate;
		actual_rotation += delta_rotate;
		delta_rotate *= PI / 180;
		rotate_x(delta_rotate.x);
		rotate_y(delta_rotate.y);
		rotate_z(delta_rotate.z);