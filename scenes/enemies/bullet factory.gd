extends Node

onready var main = get_tree().get_root().get_node("main");
onready var player = main.get_node("player");

var shoot_towards; # absolute, player, outward
var shoot_angle = 0;

var total_time = 0;

var bullet;
var shoot_delay = 1;
var last_shot = 0;

var shotgun_bullets = 1;
var shotgun_angle = 0;

func _ready():
	add_to_group("bullet factories");
	
	shoot_angle = deg2rad(shoot_angle);

# should be extended and changed to work with phases
func enemy_process(delta, phase):
	total_time += delta;
	
	if total_time - last_shot >= shoot_delay: 
		_shoot();
		last_shot = total_time;
		
func _shoot():
	if bullet == null:
		return;
		
	var center_angle = 0;
	if shoot_towards == "absolute":
		pass;
	elif shoot_towards == "player":
		var self_pos = self.global_transform.origin;
		var player_pos = player.global_transform.origin;
		center_angle = PI - Vector2(self_pos.x, self_pos.z).angle_to_point(Vector2(player_pos.x, player_pos.z));
	elif shoot_towards == "outward":
		center_angle = _initial_angle();
	else:
		print("shoot machine broke: " + self.name);
		
	center_angle += shoot_angle;
	
	var initial_angle = center_angle - (((float(shotgun_bullets) / 2) - 0.5) * deg2rad(shotgun_angle));
	
	for i in range(0, shotgun_bullets):
		var new_bullet = bullet.instance();
		new_bullet.transform.origin = self.global_transform.origin;
		new_bullet.rotation.y += initial_angle + (i * deg2rad(shotgun_angle));
		main.add_child(new_bullet);
		
# meant to be overridden by subclasses - returns the parent enemy's angle
# delegated to subclass because not all bullet factories are direct children of their parent enemy
func _initial_angle():
	pass;