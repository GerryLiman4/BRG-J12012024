extends Area2D


func _on_area_entered(area):
	print("area entered", area.name)


func _on_body_entered(body):
	print("body entered", body.name)
