extends Area2D

class_name BaseHealth

@export var max_health : int = 0
@export var faction_id : FactionId.Id

var current_health : int = 0

signal damaged
signal died

func initialize(max_health : int) :
	self.max_health = max_health
	current_health = max_health

func get_damaged(position : Vector2, damage : int, opposing_faction : FactionId.Id) : 
	if current_health <= 0 or faction_id == opposing_faction:
		return
	
	current_health -= damage
	
	if current_health <= 0 :
		died.emit()
		return
	
	damaged.emit()
