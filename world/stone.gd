extends "res://world/resource.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#_health = 3
	$Sprite2D.region_rect.position.x = 32 * _health
	$Sprite2D.region_rect.position.y = 64


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
