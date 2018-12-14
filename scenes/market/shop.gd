extends Node

var item_type;
var shopkeeper;
var equipment = [];

var shop_manager;
var equipment_manager;

onready var points = get_node("points");

onready var side = sign(self.global_transform.origin.x); # 1 = left, -1 = right

func _ready():
	randomize_shop();

func randomize_shop():
	if shop_manager == null:
		shop_manager = load("res://scenes/npcs/shopkeepers/shop manager.gd").new();
	if equipment_manager == null:
		equipment_manager = load("res://scenes/player/equipment/equipment manager.gd").new();
		
	var item_types = equipment_manager.equipment.keys();
	item_type = item_types[randi() % item_types.size()];
	
	equipment.clear();
	var equipment_of_type = equipment_manager.equipment[item_type];
	for i in range(3):
		equipment.append(equipment_manager.get_random_equipment_of_type(item_type));
				
	for i in range(0, points.get_child_count()):
		var point = points.get_child(i);
		
		for j in range(0, point.get_child_count()):
			point.get_child(j).queue_free();
			
		if point.name.find("equipment") != -1:
			var item = equipment[i].get_equipment().instance();
			item.translation = -item.get_node("equip point").translation;
			point.add_child(item);
		
	var shopkeeper = shop_manager.get_random_shopkeeper().instance();
	
	var shopkeeper_node = points.get_node("shopkeeper");
	for i in range(0, shopkeeper_node.get_child_count()):
		shopkeeper_node.get_child(i).queue_free();
	shopkeeper.translation = -shopkeeper.get_node("attach point").translation;
	shopkeeper_node.add_child(shopkeeper);
	
	var roof = get_node("roof/top");
	var material = SpatialMaterial.new();
	material.albedo_color = Color(randf(), randf(), randf());
	material.metallic_specular = 0;
	roof.set_surface_material(0, material);
	
func is_current():
	return get_node("camera").current;
	
func _physics_process(delta):
	var description = get_node("description");
	if not is_current():
		description.hide();
		return;
		
	var offset = get_tree().get_root().get_node("main/player").translation.z - self.global_transform.origin.z;
	offset *= side;
	var i = round(offset / 2) + 1;
	var item = equipment[i];
	
	description.show();
	description.translation = get_node("points/equipment " + str(i + 1)).translation + Vector3(1.1, 3.3, 0);
	
	var viewport = description.get_node("viewport");
	viewport.get_node("monet label").text = str(equipment_manager.get_price(item));
	
	var stats = viewport.get_node("stats");
	stats.text = "";
	for key in item.stats:
		var number = item.stats[key];
		if number == 0: continue;
		stats.text += ("+" if number > 0 else "") + str(number) + " " + key + "\n";