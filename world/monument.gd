extends "res://world/building.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("monument")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if Game.area_cleared:
		return
		
	if area.get_parent().is_in_group("follower"):
		
		if area.get_parent().is_leader:
			get_tree().get_first_node_in_group("ui").show_prompt("summon creature")


func _on_area_2d_area_exited(area: Area2D) -> void:
	if Game.area_cleared:
		return
	get_tree().get_first_node_in_group("ui").hide_prompt()
