extends Area2D

class_name BaseProjectile

@export var speed : float = 5.0

var is_boss : bool = false
var faction_id : FactionId.Id = FactionId.Id.NEUTRAL
var move_direction : Vector2 = Vector2.ZERO

func initialize(
designated_faction : FactionId.Id ,
launch_direction : Vector2,
is_boss : bool = false,
subtitute_speed : float = speed) :
	
	faction_id = designated_faction
	speed = subtitute_speed
	self.is_boss = is_boss
	move_direction = launch_direction

func _physics_process(delta):
	move(delta)

func move(delta):
	global_position += move_direction * speed

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
