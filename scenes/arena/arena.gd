extends Spatial

var enemies = {
	"conke can": preload("res://scenes/enemies/conke can/conke can.tscn"),
	"cube": preload("res://scenes/enemies/cube/cube.tscn"),
	"cosmic crab": preload("res://scenes/enemies/crab/crab.tscn"),
	"milk glass": preload("res://scenes/enemies/milk/milk glass.tscn"),
	"unlimited stick": preload("res://scenes/enemies/stick/stick.tscn")
};
var wave = 0;
# [enemy, spawn chance, spawn tries]
var spawns = [
	[[enemies["conke can"], 80, 2], [enemies["cube"], 40, 3], [enemies["cosmic crab"], 20, 6]],
	[[enemies["conke can"], 90, 2], [enemies["cube"], 60, 4], [enemies["cosmic crab"], 50, 3]]
];
onready var safezone = get_node("Safezone");
onready var enemy_spawn = get_node("Enemy Spawn");

var spawn_positions = [];

var confirmations = 0;

func done_extending():
	confirmations += 1;
	
	if confirmations == 8:
		confirmations = 0;
		wave += 1;
		_spawn_enemies();
		
func _spawn_enemies():
	spawn_positions = [];
	
	var enemies = spawns[wave];
	for enemy_chances in enemies:
		for i in range(enemy_chances[1]):
			if rand_range(0, 100) < enemy_chances[2]:
				var position = _find_eligible_safe_location();
				
func _find_eligible_spawn_location():
	