extends "res://creature/enemy_creature.gd"


var _attacking: bool = false
var _enemy_target = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	$AnimationPlayer.play("e_idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	if _health <= 0: 
		return
		
	if _attacking:
		$AnimationPlayer.play("e_attack")
		if $AttackCooldown.is_stopped() and $AttackTimer.is_stopped():
			$AttackTimer.start()
	else:
		$AnimationPlayer.play("e_idle")

		
	#if _direction != Vector2.ZERO and not _attacking:
		#$AnimationPlayer.play("w_walk")

#
#func set_idle_anim() -> void:
	#if $AnimationPlayer.current_animation != "w_idle" and not _attacking:
		#$AnimationPlayer.play("w_idle")
		#$AnimationPlayer.seek(randf_range(0, 0.9))
	#

	
func die() -> void:
	if len(camp.members) == 1:
		camp.get_node("CPUParticles2D").emitting = true
		Game.add_resource(Game.RESOURCE_TYPE.GOLD, camp.reward)
		$AudioStreamPlayer3.play()
	$AnimationPlayer.play("e_die")
	await $AnimationPlayer.animation_finished


func _on_area_2d_area_entered(area: Area2D) -> void:
	var _obj = area.get_parent()
	if _obj.is_in_group("follower"):
		_enemy_target = _obj
		_attacking = true
		$AttackTimer.start()


func _on_area_2d_area_exited(area: Area2D) -> void:
	var obj = area.get_parent()
	if obj.is_in_group("follower"):
		_attacking = false

		
func _on_attack_timer_timeout() -> void:
	if _enemy_target != null and _health > 0 and position.distance_to(_enemy_target.position) < 20:
		_enemy_target.damage(50.0)
		$AttackCooldown.start()


func _on_attack_cooldown_timeout() -> void:
	pass # Replace with function body.
