extends "res://creature/creature.gd"

var is_leader: bool = false
var front = null
var behind = null 
var _target_position: Vector2 = Vector2.ZERO
var _queue_idle = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _health <= 0:
		return  
		
	if is_leader:
		_target_position = get_tree().get_first_node_in_group("player").mouse_position
	elif front != null:
		_target_position = front.position
			
	var desired_direction = (_target_position - position).normalized()

	var direction_difference = desired_direction - _direction
	var inertia_factor = 0.3
	_direction = _direction.lerp(desired_direction, inertia_factor)
	_direction = _direction.normalized()
	
	if _target_position.distance_squared_to(position) < 64:
		_direction = Vector2.ZERO
		_queue_idle = true
		if $Timer.is_stopped():
			$Timer.start()

	position += _direction * _speed * delta
	
	
	if _direction.x > 0:
		$Sprite2D.flip_h = false
	elif _direction.x < 0:
		$Sprite2D.flip_h = true
		
		
func set_idle_anim():
	pass
		

func _on_timer_timeout() -> void:
	if _health <= 0:
		return  
		
	if front != null:
		if front._direction == Vector2.ZERO:
			set_idle_anim()
			_queue_idle = false
	else:
		set_idle_anim()
		_queue_idle = false
