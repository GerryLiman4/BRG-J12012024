extends Node

@export var bgm_stream : AudioStreamPlayer2D
@export var sfx_stream : AudioStreamPlayer2D

const audio_bus_bgm : String = "BGM"
const audio_bus_sfx : String = "SFX"

const AUDIO_SETTING_SECTION_KEY : String = "AUDIO"
const BGM_ENABLED_CONFIG_KEY : String = "BGM_ENABLED"  
const SFX_ENABLED_CONFIG_KEY : String = "SFX_ENABLED"  

const file_path : String = "user://player_config.cfg"

var config = ConfigFile.new()

func _enter_tree():
	load_audio_setting()

func load_audio_setting():
	var loader = config.load(file_path)
	
	var is_bgm_on : bool = true
	var is_sfx_on : bool = true
	
	if loader == OK :
		is_bgm_on = config.get_value(AUDIO_SETTING_SECTION_KEY,BGM_ENABLED_CONFIG_KEY,true)
		is_sfx_on = config.get_value(AUDIO_SETTING_SECTION_KEY,SFX_ENABLED_CONFIG_KEY,true)
	
	save_audio_setting(is_bgm_on,is_sfx_on)

func save_audio_setting(bgm_enabled : bool , sfx_enabled : bool):
	AudioServer.set_bus_mute(AudioServer.get_bus_index(audio_bus_bgm),!bgm_enabled)
	AudioServer.set_bus_mute(AudioServer.get_bus_index(audio_bus_sfx),!sfx_enabled)
	
	config.set_value(AUDIO_SETTING_SECTION_KEY,BGM_ENABLED_CONFIG_KEY,bgm_enabled)
	config.set_value(AUDIO_SETTING_SECTION_KEY,SFX_ENABLED_CONFIG_KEY,sfx_enabled)
	config.save(file_path)

func play_bgm_stream(bgm : AudioStream, overlap : bool = false) :
	if !overlap && bgm_stream.stream == bgm:
		return
	
	bgm_stream.stream = bgm
	bgm_stream.play()

func stop_bgm_stream():
	bgm_stream.stop()

func play_sfx_stream(sfx : AudioStream, overlap : bool = false) :
	if !overlap && sfx_stream.stream == sfx:
		return
	
	sfx_stream.stream = sfx
	sfx_stream.play()

func stop_sfx_stream():
	sfx_stream.stop()
