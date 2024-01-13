extends CharacterBody2D

class_name BaseEnemy

@export var state_chart : StateChart
@export var animator : AnimationPlayer
@export var sfx_stream : AudioStreamPlayer2D
@export var attack_delay_timer : Timer

const STATE_EVENT = {
	"NONE" : "None",
	"IDLE" : "Idle",
	"RANDOM_MOVEMENT" : "RandomMovement",
	"CHASE" : "Chase",
	"DIE" : "Die",
	"STAGGER" : "Stagger",
	"SPECIAL_1" : "Special1",
	"SPECIAL_2" : "Special2",
	"SPECIAL_3" : "Special3",
	"SPECIAL_4" : "Special4"
}

var move_destinations : Array[Vector2]
var current_state_event : String = STATE_EVENT.NONE

func switch_state(new_state : String) :
	if current_state_event == new_state :
		return
	
	state_chart.send_event(new_state)
	current_state_event = new_state

#region state
func _on_none_state_entered():
	pass # Replace with function body.


func _on_none_state_exited():
	pass # Replace with function body.


func _on_idle_state_entered():
	pass # Replace with function body.


func _on_idle_state_exited():
	pass # Replace with function body.


func _on_random_movement_state_entered():
	pass # Replace with function body.


func _on_random_movement_state_exited():
	pass # Replace with function body.


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
	pass # Replace with function body.


func _on_special_1_state_exited():
	pass # Replace with function body.


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
