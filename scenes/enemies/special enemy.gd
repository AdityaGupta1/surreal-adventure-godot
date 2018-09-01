extends "res://scenes/enemies/enemy.gd"
# don't forget to extend _move()

var phase = 0;

func _physics_process(delta):
	if !_has_player():
		return;
	
	_move(delta);
	
	if not levitates:
		move_and_collide(Vector3(0, gravity * delta, 0));
	
	total_time += delta;
	
	if total_time < shoot_delay:
		return;
	
	for node in get_children():
		if node.get_class() == "bullet factory":
			node.enemy_process(delta, phase);
	
# should be extended because different enemies might have different rotations
func _get_rotation():
	pass;