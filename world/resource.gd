extends Node2D

@export var type: Game.RESOURCE_TYPE = 0

var _health: int = 4


# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	$Sprite2D.region_rect.position.x = 32 * _health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func add_health() -> void:
	_health += min(4, _health + 0.5)
	$Sprite2D.region_rect.position.x = 32 * _health
	
	
func remove_health() -> void:
	if _health > 0:
		$CPUParticles2D.emitting = true
		_health = max(0, _health - 0.5)
		$Sprite2D.region_rect.position.x = 32 * _health
		Game.add_resource(type)
		$AudioStreamPlayer.pitch_scale = randf_range(0.9, 1.1)
		$AudioStreamPlayer.play()
		if _health <= 0:
			pass
			#get_tree().get_first_node_in_group("world").drop_item(type, position)
			#queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("gatherer"):
		remove_health()


func _on_area_2d_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
