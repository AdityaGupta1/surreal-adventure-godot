extends Node

var health_restored = {
	"bepis can": 15
};

func _ready():
	set_collision_layer(33); # player and enemies
	set_collision_mask(0);
	
func _on_body_entered(body):
	if body.get_name() == "Player":
		get_tree().get_root().get_node("Main").get_node("Player").heal(health_restored[self.get_name()]);
		queue_free();