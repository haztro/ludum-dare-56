class_name Creature
extends Node2D

var _direction: Vector2 = Vector2.ZERO
var _speed: float = 40.0
var _health: float = 100.0
var _dead: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.flip_h = randi_range(0, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func die():
	pass


func damage(damage: float) -> void:
	_health -= damage
	#$AudioStreamPlayer2.pitch_scale = randf_range(0.9, 1.1)
	$AudioStreamPlayer2.play()
	if _health <= 0:
		if not _dead:
			$AudioStreamPlayer.play()
			_dead = true
			await die()
			queue_free()
