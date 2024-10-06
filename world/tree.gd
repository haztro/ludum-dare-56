extends "res://world/resource.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	$Sprite2D.region_rect.position.y = 32.0 * randi_range(0, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
