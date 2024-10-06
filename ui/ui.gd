extends MarginContainer


var resource_icons = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in $HBoxContainer.get_children():
		resource_icons[child.type] = child


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("spacebar") and $PromptBox.visible:
		get_tree().paused = true
		$SummonMenu.show_menu()
		
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		
	if Input.is_action_just_pressed("fullscreen"):
		if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	#elif Input.is_action_just_pressed("esc") and get_tree().paused:
		#get_tree().paused = false
	
		
		

func fade_out():
	var tween = get_tree().create_tween()
	tween.tween_property(get_parent().get_node("Panel"), "modulate:a", 1.0, 2.0)
	await tween.finished
	if get_tree():
		get_tree().reload_current_scene()
	
	
	
func win_state():
	show_prompt("another planet saved...")



func show_prompt(text: String) -> void:
	$PromptBox.show_prompt(text)
	
	
func hide_prompt() -> void:
	$PromptBox.hide_prompt()
	$SummonMenu.hide_menu()
