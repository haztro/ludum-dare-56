extends "res://creature/follower.gd"

var _attacking: bool = false
var _enemy_target = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	$AnimationPlayer.play("w_idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	if _direction != Vector2.ZERO and not _attacking and _health > 0:
		$AnimationPlayer.play("w_walk")
	if _attacking and _health > 0:
		$AnimationPlayer.play("w_attack")
		if $AttackCooldown.is_stopped() and $AttackTimer.is_stopped():
			$AttackTimer.start()

		


func set_idle_anim() -> void:
	if $AnimationPlayer.current_animation != "w_idle" and not _attacking:
		$AnimationPlayer.play("w_idle")
		$AnimationPlayer.seek(randf_range(0, 0.9))
	

	
func die() -> void:
	$AnimationPlayer.play("w_die")
	await $AnimationPlayer.animation_finished
	get_tree().get_first_node_in_group("player").remove_creature(self)

func _on_area_2d_area_entered(area: Area2D) -> void:
	var _obj = area.get_parent()
	if _obj.is_in_group("enemy"):
		_enemy_target = _obj
		_attacking = true
		$AttackTimer.start()
		
		
		#_enemy_target = _obj
		#$AnimationPlayer.play("w_attack")
		#$AttackTimer.start()
		#
		#_attacking = true
		#await $AnimationPlayer.animation_finished
		#_attacking = false
		

func _on_area_2d_area_exited(area: Area2D) -> void:
	_attacking = false


func _on_attack_timer_timeout() -> void:
	if _enemy_target != null and _health > 0:
		_enemy_target.damage(50.0)
		$AttackCooldown.start()


func _on_attack_cooldown_timeout() -> void:
	pass # Replace with function body.
