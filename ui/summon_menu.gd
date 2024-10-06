extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("HBoxContainer/VBoxContainer/HBoxContainer/Control2").set_value(Game.GATHERER_FOOD_COST)
	get_node("HBoxContainer/VBoxContainer/HBoxContainer/Control").set_value(Game.GATHERER_WOOD_COST)
	
	get_node("HBoxContainer/VBoxContainer2/HBoxContainer/Control").set_value(Game.WARRIOR_FOOD_COST)
	get_node("HBoxContainer/VBoxContainer2/HBoxContainer/Control3").set_value(Game.WARRIOR_WOOD_COST)
	get_node("HBoxContainer/VBoxContainer2/HBoxContainer/Control2").set_value(Game.WARRIOR_STONE_COST)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("spacebar") and visible:
		if get_node("HBoxContainer/VBoxContainer/PanelContainer/Panel").visible:
			if Game.summon_creature(Game.CREATURE_TYPE.GATHERER):
				hide_menu()
			else:
				$AudioStreamPlayer.play()
				
		elif get_node("HBoxContainer/VBoxContainer2/PanelContainer/Panel2").visible:
			if Game.summon_creature(Game.CREATURE_TYPE.WARRIOR):
				hide_menu()
			else:
				$AudioStreamPlayer.play()
			
	if Input.is_action_just_pressed("esc"):
		hide_menu()


func show_menu():
	mouse_filter = MOUSE_FILTER_PASS
	visible = true
	
func hide_menu():
	get_tree().paused = false
	mouse_filter = MOUSE_FILTER_IGNORE
	visible = false



func _on_v_box_container_mouse_entered() -> void:
	get_node("HBoxContainer/VBoxContainer/PanelContainer/Panel").visible = true
	

func _on_v_box_container_mouse_exited() -> void:
	get_node("HBoxContainer/VBoxContainer/PanelContainer/Panel").visible = false


func _on_v_box_container_2_mouse_entered() -> void:
	get_node("HBoxContainer/VBoxContainer2/PanelContainer/Panel2").visible = true


func _on_v_box_container_2_mouse_exited() -> void:
	get_node("HBoxContainer/VBoxContainer2/PanelContainer/Panel2").visible = false
