extends BaseProjectile

func _on_body_entered(body):
	if body.is_in_group("health") :
		body.get_damaged(global_position,damage, faction_id)
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("health") :
		area.get_damaged(global_position,damage,faction_id)
		queue_free()
