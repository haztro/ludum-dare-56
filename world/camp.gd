class_name Camp
extends Node2D


var members = []
var reward = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("fire")
	get_tree().get_first_node_in_group("world").add_enemy(self)
	reward = len(members)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
