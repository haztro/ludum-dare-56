extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func show_prompt(text: String) -> void:
	$Label.text = text
	visible = true
	

func hide_prompt() -> void:
	visible = false
