extends Spatial

signal retract;

var paused = false;
var load_data;

func _init():
	load_data = _load();

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
		
func _notification(event):
	if event == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		_save();
		get_tree().quit();
		
func _save():
	var data = {
		muted = get_node("pause screen/muted").is_muted()
	}
	
	# Open a file
	var file = File.new();
	if file.open("user://options.save", File.WRITE) != 0:
		print("error opening file");
		return;
	
	file.store_string(to_json(data));
	file.close();
	
func _load():
	var file = File.new();
	if not file.file_exists("user://options.save"):
		print("no file saved");
		return;
	
	if file.open("user://options.save", File.READ) != 0:
		print("error opening file");
		return;
	
	return parse_json(file.get_as_text());