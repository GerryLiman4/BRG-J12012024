extends Control

@export var bgm_track : AudioStream

func _ready():
	AudioManager.play_bgm_stream(bgm_track,true)

func _on_start_button_is_selected(selected_button):
	AudioManager.stop_bgm_stream()
	SceneHandler.load_scene(SceneHandler.SCENES.BATTLE_ARENA)


func _on_how_to_play_button_is_selected(selected_button):
	pass # Replace with function body.


func _on_exit_button_is_selected(selected_button):
	get_tree().quit()
