extends CanvasLayer

func _input(event):
	if event.is_action_pressed("ui_cancel") :
		if get_tree().current_scene.name.to_upper() != SceneHandler.BATTLE_ARENA_SCENE.replace("_","") :
			return
		
		visible = !visible
		get_tree().paused = visible


func _on_continue_button_is_selected(selected_button):
	visible = false
	get_tree().paused = visible


func _on_main_menu_button_is_selected(selected_button):
	visible = false
	get_tree().paused = false
	
	SceneHandler.load_scene(SceneHandler.SCENES.MAIN_MENU)


func _on_exit_button_is_selected(selected_button):
	get_tree().quit()
