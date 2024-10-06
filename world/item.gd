extends Node2D


var item_drop_position: Vector2 = Vector2(0, -8)  # How high the item should go up
var bounce_height: float = -4  # Height of the bounce

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func drop_item(at_position: Vector2):
	position = at_position
	# Create a tween for the item
	var tween = create_tween().set_parallel(true)  # Parallel tween for simultaneous animations
	# Move item up
	tween.tween_property(self, "position", at_position + item_drop_position, 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

	# Bounce animation
	tween.tween_property(self, "position:y", at_position.y - bounce_height, 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y", at_position.y, 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
