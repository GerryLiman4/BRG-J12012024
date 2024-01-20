extends BaseSkill

@export var animator : AnimationPlayer

@export_category("Bullet Configuration")
@export var bullet_speed : float = 200.0

const ANIMATION_ID = {
	"SHOOT" : "Shoot",
}

func initialize(spawn_roots : Array[Node2D],is_boss : bool = false) :
	super.initialize(spawn_roots,is_boss)

func activate_skill():
	animator.play(ANIMATION_ID.SHOOT)
