extends TextureRect


@export var type: Game.RESOURCE_TYPE = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_value(value):
	$Label.text = str(value)
