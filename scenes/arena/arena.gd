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
	[[enemies["conke can"], 80, 2], [enemies["cube"], 60, 2], [enemies["cosmic crab"], 75, 2]],
	[[enemies["conke can"], 90, 2], [enemies["cube"], 60, 3], [enemies["cosmic crab"], 85, 2]],
	[[enemies["conke can"], 100, 2], [enemies["cube"], 80, 3], [enemies["cosmic crab"], 100, 1], [enemies["milk glass"], 75, 2]]
];

var spawn_positions = [];

var confirmations = 0;

func start():
	_spawn_enemies();

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
		for i in range(enemy_chances[2]):
			if rand_range(0, 100) < enemy_chances[1]:
				var enemy = enemy_chances[0].instance();
				enemy.transform.origin = _find_eligible_spawn_location();
				get_tree().get_root().get_node("Main").get_node("enemies").add_child(enemy);
				
func _generate_random_coordinate():
	return (((randi() % 2) * 2) - 1) * rand_range(6, 16);
	
func _is_eligible_spawn_location(x, z):
	for position in spawn_positions:
		if Vector2(position[0], position[1]).distance_to(Vector2(x, z)) <= 2:
			return false;
			
	return true;
				
func _find_eligible_spawn_location():
	var x;
	var z;
	
	while true:
		x = _generate_random_coordinate();
		z = _generate_random_coordinate();
		
		if _is_eligible_spawn_location(x, z):
			break;
	
	spawn_positions.append([x, z]);
	return Vector3(x, 22.5, z);
	