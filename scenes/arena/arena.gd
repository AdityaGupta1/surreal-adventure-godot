extends Spatial

var enemies = {
	"conke can": preload("res://scenes/enemies/conke can/conke can.tscn"),
	"cube": preload("res://scenes/enemies/cube/cube.tscn"),
	"cosmic crab": preload("res://scenes/enemies/crab/crab.tscn"),
	"milk glass": preload("res://scenes/enemies/milk/milk glass.tscn"),
	"unlimited stick": preload("res://scenes/enemies/stick/stick.tscn")
};
var wave = 0;
const healing_items = [
	preload("res://scenes/player/healing/bepis can.tscn")
]
# [enemy, spawn chance, spawn tries]
var spawns = [
	[[enemies["conke can"], 100, 1, 80, 1], [enemies["cube"], 100, 1], [enemies["cosmic crab"], 90, 1]],
	[[enemies["conke can"], 100, 2], [enemies["cube"], 100, 1, 80, 1], [enemies["cosmic crab"], 100, 1, 40, 1]],
	[[enemies["conke can"], 100, 2, 50, 1], [enemies["cube"], 100, 2], [enemies["cosmic crab"], 80, 2], [enemies["milk glass"], 100, 1]]
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
		for i in range(1, enemy_chances.size(), 2):
			for j in range(enemy_chances[i + 1]):
				if rand_range(0, 100) < enemy_chances[i]:
					var enemy = enemy_chances[0].instance();
					enemy.transform.origin = _find_eligible_spawn_location();
					get_tree().get_root().get_node("Main").get_node("enemies").add_child(enemy);

func _random_vector(bound):
	return Vector3(rand_range(-bound, bound), rand_range(0, bound), rand_range(-bound, bound));

func spawn_healing_items():
	for i in range(5 + (wave * 2)):
		var new_healing_item = healing_items[randi() % healing_items.size()].instance();
		
		var position = global_transform.origin;
		position.y = 22.5;
		new_healing_item.transform.origin = position;
		
		new_healing_item.apply_impulse(position, _random_vector(6));
		
		new_healing_item.rotation.x = rand_range(0, 2 * PI);
		new_healing_item.rotation.y = rand_range(0, 2 * PI);
		new_healing_item.rotation.z = rand_range(0, 2 * PI);
		
		var spatial = Spatial.new();
		
		get_parent().add_child(spatial);
		spatial.add_child(new_healing_item);

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
	