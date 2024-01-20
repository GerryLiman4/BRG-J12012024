extends CharacterBody2D

@export var movement_speed : float = 100.0

@export var state_machine : StateChart

@export_category("Animation")
@export var thruster_animation : AnimatedSprite2D
@export var model : Sprite2D
@export var skew_angle : float = 2.0

@export_category("Skills")
@export var skill_list_prefab : Array[PackedScene]
@export var skill_root : Node2D

const STATE_EVENT = {
	"NONE" : "None",
	"IDLE" : "Idle",
	"MOVING" : "Moving",
	"DASH" : "Dash",
	"DIE" : "Die"
}

const STATE_CONDITION = {
	"NONE" : "None",
	"HURT" : "Hurt",
	"SPECIAL_1" : "Special1",
}

var move_direction : Vector2 = Vector2.ZERO

var current_event_state : String
var current_condition_state : String

var skill_list : Array[BaseSkill] = []

# for test, comment if not testing
func _ready():
	initialize()

func initialize() :
	initialize_skills()
	switch_state_event(STATE_EVENT.IDLE)

func initialize_skills():
	for skill in skill_list_prefab :
		var instantiated_skill : BaseSkill = skill.instantiate()
		var spawn_roots : Array[Node2D] = [skill_root]
		instantiated_skill.initialize(spawn_roots)
		skill_root.call_deferred("add_child",instantiated_skill)

func move(delta) :
	velocity = Vector2.ZERO
	move_direction = Vector2.ZERO
	check_input()
	
	velocity = move_direction * movement_speed
	move_and_slide()

func check_input():
	if Input.is_action_pressed("ui_up") && Input.is_action_pressed("ui_down") :
		move_direction.y = 0
	elif Input.is_action_pressed("ui_down") :
		move_direction.y = 1
	elif Input.is_action_pressed("ui_up") :
		move_direction.y = -1
	
	if Input.is_action_pressed("ui_left") && Input.is_action_pressed("ui_right") :
		move_direction.x = 0
	elif Input.is_action_pressed("ui_right") :
		move_direction.x = 1
	elif Input.is_action_pressed("ui_left") :
		move_direction.x = -1
	

func switch_state_event(new_state : String, overlap : bool = false) : 
	if current_event_state == new_state && !overlap :
		return
	
	state_machine.call_deferred("send_event",new_state)
	current_event_state = new_state

func switch_state_condition(new_state : String, overlap : bool = false) : 
	if current_condition_state == new_state && !overlap :
		return
	
	state_machine.call_deferred("send_event",new_state)
	current_condition_state = new_state

func check_movement_condition():
	if velocity != Vector2.ZERO :
		switch_state_event(STATE_EVENT.MOVING)
	else : 
		switch_state_event(STATE_EVENT.IDLE)

func skew_model():
	if velocity.x > 0 :
		model.global_skew = deg_to_rad(skew_angle)
	elif velocity.x < 0 :
		model.global_skew = deg_to_rad(skew_angle * -1.0)
	else : 
		model.global_skew = 0

#region state 

func _on_idle_state_entered():
	play_thruster_animation()

func _on_idle_state_processing(delta):
	check_movement_condition()

func _on_idle_state_physics_processing(delta):
	move(delta)

func _on_moving_state_exited():
	skew_model()

func _on_moving_state_entered():
	play_thruster_animation()

func _on_moving_state_processing(delta):
	skew_model()
	check_movement_condition()

func _on_moving_state_physics_processing(delta):
	move(delta)
#endregion

func play_thruster_animation():
	if move_direction == Vector2.ZERO :
		thruster_animation.play(AnimationId.Thruster.IDLE)
		return
	
	if move_direction == Vector2.UP :
		thruster_animation.play(AnimationId.Thruster.FORWARD)
		return
	
	if move_direction == Vector2.DOWN :
		thruster_animation.play(AnimationId.Thruster.BACKWARD)
		return


