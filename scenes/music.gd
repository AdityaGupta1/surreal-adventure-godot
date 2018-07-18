extends AudioStreamPlayer3D

const max_ambient_track = 2;
var ambient_tracks = [];
var now_playing = -1;

func _ready():
	for i in range(1, max_ambient_track + 1):
		ambient_tracks.append(load("res://sounds/ambient/ambient" + str(i) + ".ogg"));
	
	_play_music();

func _play_music():
	randomize();
	
	var random_track = now_playing;
	
	while random_track == now_playing:
		random_track = randi() % max_ambient_track;
		print(random_track);
	
	set_stream(ambient_tracks[random_track]);
	play();