extends Node2D


@export var _speed = 40.0

var _direction: Vector2 = Vector2.ZERO
var mouse_position: Vector2 = Vector2.ZERO

var creatures = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func add_creature(creature: Creature):
	if creatures.is_empty():
		creature.position = position
		creature.is_leader = true
	else:
		creature.front = creatures.back()
		creatures.back().behind = creature
		creature.position = creatures.back().position
		
	creatures.append(creature)
	Game.add_resource(Game.RESOURCE_TYPE.CREATURES)
	get_tree().get_first_node_in_group("world").add_child(creature)
	
	
func remove_creature(creature: Creature):

	if creature.is_leader:
		if creature.behind != null:
			creature.behind.is_leader = true
			creature.behind.front = null
	else:
		if creature.behind != null:
			creature.front.behind = creature.behind
			creature.behind.front = creature.front
		else:
			creature.front.behind = null
			
	
	creatures.erase(creature)
	Game.remove_resource(Game.RESOURCE_TYPE.CREATURES)
		
	if creatures.is_empty():
		await get_tree().get_first_node_in_group("ui").fade_out()
		return 
		
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_get_movement_direction()
	_get_aim_direction()
	#print(position)
	if _direction != Vector2.ZERO:
		position += _direction * _speed * delta 
		var test_pos = position 
		var half_cam = (get_viewport_rect().size/$Camera2D.zoom)/2
		if test_pos.x > 800-half_cam.x or test_pos.x < -800 + half_cam.x: 
			position.x -= _direction.x * _speed * delta 
		if test_pos.y > 400 - half_cam.y or test_pos.y < -400 + half_cam.y:
			position.y -= _direction.y * _speed * delta
			
			

func _get_movement_direction() -> void:
	_direction = Vector2(0, 0)
	if Input.is_action_pressed("right"):
		_direction.x += 1
	if Input.is_action_pressed("left"):
		_direction.x -= 1
	if Input.is_action_pressed("down"):
		_direction.y += 1
	if Input.is_action_pressed("up"):
		_direction.y -= 1
	_direction = _direction.normalized()


func _get_aim_direction():
	var mouse_pos = get_viewport().get_mouse_position()
	var scaled_pos = (get_global_transform_with_canvas().origin)
	mouse_position = (mouse_pos - scaled_pos) / $Camera2D.zoom + position 
