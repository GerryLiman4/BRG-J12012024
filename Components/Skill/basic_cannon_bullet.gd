extends BaseProjectile

@export var sfx_stream : AudioStream 

func _on_body_entered(body):
	if body.is_in_group("health") :
		play_sfx()
		body.get_damaged(global_position,damage, faction_id)
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("health") :
		play_sfx()
		area.get_damaged(global_position,damage,faction_id)
		queue_free()

func play_sfx():
	AudioManager.play_sfx_stream(sfx_stream)
