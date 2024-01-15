extends Control

func _on_start_button_is_selected(selected_button):
	SceneHandler.load_scene(SceneHandler.SCENES.BATTLE_ARENA)


func _on_how_to_play_button_is_selected(selected_button):
	pass # Replace with function body.


func _on_exit_button_is_selected(selected_button):
	get_tree().quit()
