extends BaseSkill

@export var animator : AnimationPlayer

@export_category("Bullet Configuration")
@export var bullet_prefab : PackedScene
@export var bullet_speed : float = 200.0
@export var bullet_damage : int = 1
@export var direction : Vector2 = Vector2.ZERO
@export var spawn_point : Marker2D

@export_category("SFX")
@export var sfx_player : AudioStreamPlayer2D
@export var shoot_sfx : AudioStream

const ANIMATION_ID = {
	"SHOOT" : "Shoot",
}

func initialize(spawn_roots : Array[Node2D],is_boss : bool = false) :
	super.initialize(spawn_roots,is_boss)

func activate_skill():
	if is_cooldown == true : return
	
	is_cooldown = true
	start_cooldown_timer()
	
	animator.stop()
	animator.play(ANIMATION_ID.SHOOT)

func shoot():
	var faction_id : FactionId.Id = FactionId.Id.NEUTRAL
	var launch_direction : Vector2 = direction
	
	if is_boss_possesion : 
		faction_id = FactionId.Id.ENEMY
		launch_direction.y = 1
	else : 
		faction_id = FactionId.Id.PLAYER
		launch_direction.y = -1
	
	var instantiated_bullet : BaseProjectile = bullet_prefab.instantiate()
	instantiated_bullet.initialize(faction_id,launch_direction,is_boss_possesion)
	instantiated_bullet.global_position = spawn_point.global_position
	get_tree().root.call_deferred("add_child",instantiated_bullet)
	
	play_sfx()

func play_sfx():
	sfx_player.stream = shoot_sfx
	sfx_player.play()
