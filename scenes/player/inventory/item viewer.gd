extends Control

func init(equipment):
	get_node("rectangle").texture = get_node("viewport").get_texture();
	print(equipment);
	get_node("viewport").add_child(equipment.get_equipment().instance());