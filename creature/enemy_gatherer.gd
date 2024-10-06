extends "res://creature/enemy_creature.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	$AnimationPlayer.play("eg_idle")


func die() -> void:
	if camp.members.is_empty():
		camp.get_node("CPUParticles2D").emitting = true
		Game.add_resource(Game.RESOURCE_TYPE.GOLD, camp.reward)
		$AudioStreamPlayer3.play()
		
		
	$AnimationPlayer.play("eg_die")
	await $AnimationPlayer.animation_finished

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#super._process(delta)
	#if _direction != Vector2.ZERO:
		#$AnimationPlayer.play("g_walk")
#
#
#func set_idle_anim() -> void:
	#if $AnimationPlayer.current_animation != "g_idle":
		#$AnimationPlayer.play("g_idle")
		#$AnimationPlayer.seek(randf_range(0, 0.9))
	#
