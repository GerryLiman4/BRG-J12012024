extends Camera2D

@export var random_strength : float = 5.0
@export var shake_fade : float = 5.0

var rng = RandomNumberGenerator.new()

var shake_strength : float = 0.0 
var original_offset : Vector2

func _ready():
	set_process(false)
	
	SignalManager.on_boss_hp_updated.connect(on_boss_hp_updated)

func on_boss_hp_updated(max_hp : int , updated_hp : int):
	start_shake()

func start_shake():
	set_shake_strength()
	original_offset = offset
	set_process(true)
	SignalManager.on_camera_start_shaking.emit()

func stop_shake():
	reset_offset()
	set_process(false)
	SignalManager.on_camera_stop_shaking.emit()

func _process(delta):
	if shake_strength > 0 :
		shake_strength = lerpf(shake_strength, 0 , shake_fade * delta)
		
		offset = get_random_offset()
		
	elif shake_strength == 0 :
		stop_shake()

func set_shake_strength():
	shake_strength = random_strength

func reset_offset():
	offset = original_offset

func get_random_offset() -> Vector2 :
	return Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))
