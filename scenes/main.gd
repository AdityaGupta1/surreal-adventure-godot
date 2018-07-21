extends Spatial

signal retract;

var paused = false;

func _ready():
	for half in ["Right", "Left"]:
		for side in ["Top", "Right", "Bottom", "Left"]:
				connect("retract", get_node("arena/" + half + "/" + side + "/Platform"), "retract");
				
	randomize();

var awaiting_player_centered = false;

func _process(delta):
	if awaiting_player_centered:
		for body in get_node("arena/Center").get_overlapping_bodies():
				if body.get_name() == "Player":
					emit_signal("retract");
					awaiting_player_centered = false;
					body.lock_movement();

func enemy_died():
	if get_node("enemies").get_children().size() == 1:
		awaiting_player_centered = true;
		get_node("arena").spawn_healing_items();
		get_node("arena").randomize_direction();