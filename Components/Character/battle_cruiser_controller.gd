extends BaseEnemy

@export var move_timer : Timer
@export var stop_move_timer : Timer
@export var movement_speed : float = 3.0

@export var condition_animator : AnimationPlayer

@export_category("ATTACK PATTERN")
@export var slash_vfx : AnimatedSprite2D

@export_category("HEALTH")
@export var health : BaseHealth
@export var max_hp : int = 15

@export var test_timer : Timer
# for testing
func _ready():
	# connect signals
	health.damaged.connect(on_damaged)
	health.died.connect(on_died)
	
	# Initialize components
	health.initialize(max_hp)
	
	call_deferred("switch_state", STATE_EVENT.IDLE)
	slash_vfx.animation_finished.connect(on_animation_finished)

func _physics_process(delta):
	move_and_slide()

func check_enemy() :
	pass

func move_to_destination(delta : float) :
	if move_destinations.size() <= 0 :
		return
	
	if global_position == move_destinations[0] :
		return
	
	global_position = global_position.lerp(move_destinations[0],delta * movement_speed)

func stop_moving():
	velocity = Vector2.ZERO

#region state
func _on_none_state_entered():
	pass # Replace with function body.


func _on_none_state_exited():
	pass # Replace with function body.


func _on_idle_state_entered():
	animator.play(AnimationId.Id.IDLE)
	move_timer.start(move_timer.wait_time)

func _on_idle_state_processing(delta):
	pass # Replace with function body.

func _on_idle_state_exited():
	animator.stop()
	move_timer.stop()

func _on_random_movement_state_entered():
	var random_destination = Vector2(global_position.x + randf_range(-50.0,50.0),global_position.x + randf_range(-50.0,50.0))
	
	#add random destination
	move_destinations.append(random_destination)
	stop_move_timer.start(stop_move_timer.wait_time)
	#TODO play animation

func _on_random_movement_state_physics_processing(delta):
	move_to_destination(delta)

func _on_random_movement_state_exited():
	move_destinations.clear()
	stop_move_timer.stop()

func _on_chase_state_entered():
	pass # Replace with function body.


func _on_chase_state_exited():
	pass # Replace with function body.


func _on_stagger_state_entered():
	pass # Replace with function body.


func _on_stagger_state_exited():
	pass # Replace with function body.


func _on_die_state_entered():
	pass # Replace with function body.


func _on_die_state_exited():
	pass # Replace with function body.


func _on_special_1_state_entered():
	slash_vfx.visible = true
	slash_vfx.play("Slash")
	test_timer.start(test_timer.wait_time)

func _on_special_1_state_exited():
	slash_vfx.visible = false
	test_timer.stop()


func _on_special_2_state_entered():
	pass # Replace with function body.


func _on_special_2_state_exited():
	pass # Replace with function body.


func _on_special_3_state_entered():
	pass # Replace with function body.


func _on_special_3_state_exited():
	pass # Replace with function body.


func _on_special_4_state_entered():
	pass # Replace with function body.


func _on_special_4_state_exited():
	pass # Replace with function body.

#endregion

func on_damaged():
	condition_animator.play("Hurt")
	SignalManager.on_boss_hp_updated.emit(health.max_health,health.current_health)

func on_died():
	SignalManager.on_boss_hp_updated.emit(health.max_health,health.current_health)
	queue_free()

func _on_move_timer_timeout():
	call_deferred("switch_state", STATE_EVENT.RANDOM_MOVEMENT)

func _on_stop_move_timer_timeout():
	stop_moving()
	call_deferred("switch_state", STATE_EVENT.SPECIAL_1)

func _on_test_timer_timeout():
	call_deferred("switch_state", STATE_EVENT.IDLE)

func on_animation_finished() :
	slash_vfx.visible = false
