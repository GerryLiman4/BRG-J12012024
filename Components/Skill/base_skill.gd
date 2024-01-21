extends Node2D

class_name BaseSkill

@export_category("Skill Customize")
@export var cooldown_time : float = 0.0
@export var cooldown_timer : Timer

var spawn_roots : Array[Node2D]
var is_boss_possesion : bool 

var is_cooldown : bool = false

func initialize(spawn_roots : Array[Node2D],is_boss : bool = false) :
	self.spawn_roots = spawn_roots
	is_boss_possesion = is_boss

func activate_skill():
	if is_cooldown == true : return
	
	is_cooldown = true
	start_cooldown_timer()

func start_cooldown_timer():
	cooldown_timer.start(cooldown_time)

func _on_cooldown_timer_timeout():
	is_cooldown = false
