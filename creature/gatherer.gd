class_name Gatherer
extends "res://creature/follower.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	$AnimationPlayer.play("g_idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	if _direction != Vector2.ZERO and _health > 0:
		$AnimationPlayer.play("g_walk")


func set_idle_anim() -> void:
	if $AnimationPlayer.current_animation != "g_idle":
		$AnimationPlayer.play("g_idle")
		$AnimationPlayer.seek(randf_range(0, 0.9))
	
	
	
func die() -> void:
	$AnimationPlayer.play("g_die")
	await $AnimationPlayer.animation_finished
	get_tree().get_first_node_in_group("player").remove_creature(self)
