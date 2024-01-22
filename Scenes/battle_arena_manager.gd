extends Node2D

@export var boss_name : String

@export_category("HUD")
@export var boss_name_label : Label
@export var boss_hp : ProgressBar

@export var bgm_stream : AudioStream

func _ready():
	play_bgm()
	SignalManager.on_boss_hp_updated.connect(on_boss_hp_updated)
	initialize()

func initialize():
	boss_name_label.text = boss_name
	boss_hp.value = 100.0

func on_boss_hp_updated(max_hp : int , updated_hp : int):
	var val : float = float(updated_hp) / float(max_hp)  * 100.0
	boss_hp.value = val

func play_bgm():
	AudioManager.play_bgm_stream(bgm_stream)
