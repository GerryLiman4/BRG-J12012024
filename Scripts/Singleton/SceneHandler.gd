extends Node

const MAIN_MENU_SCENE : String = "MAIN_MENU"
const BATTLE_ARENA_SCENE : String = "BATTLE_ARENA"

const SCENES = {
	MAIN_MENU_SCENE : preload("res://Scenes/MainMenu/main_menu.tscn"),
	BATTLE_ARENA_SCENE : preload("res://Scenes/battle_arena.tscn"), 
}

func load_scene(packed_scene : PackedScene) :
	call_deferred("change_file_to_scene", packed_scene)

func change_file_to_scene(packed_scene : PackedScene):
	get_tree().change_scene_to_packed(packed_scene)
