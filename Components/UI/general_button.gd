extends Control

class_name GeneralButton

@onready var normal_texture = $NormalTexture
@onready var active_texture = $ActiveTexture
@onready var disable_texture = $DisableTexture
@onready var select_indicator = $SelectIndicator

var is_disabled : bool = false
var tween : Tween

signal is_selected(selected_button)

func _ready():
	active_texture.pivot_offset.x = active_texture.size.x / 2.0
	active_texture.pivot_offset.y = active_texture.size.y / 2.0

func _on_mouse_entered():
	if is_disabled :
		return
	
	reset_all_texture()
	
	active_texture.visible = true
	select_indicator.visible = true
	
	do_tween()

func do_tween() :
	tween = create_tween().set_loops()
	# make the scale bigger
	tween.tween_property(active_texture, "scale", Vector2(1.1,1.1), 0.25)
	tween.tween_property(active_texture, "scale", Vector2(1.0,1.0), 0.25)

func _on_mouse_exited():
	if is_disabled : 
		return
	
	reset_all_texture()
	normal_texture.visible = true

func _on_gui_input(event):
	if is_disabled :
		return
	
	if event is InputEventMouseButton:
		is_selected.emit(self)

func set_disabled(is_disabled : bool) :
	self.is_disabled = is_disabled
	reset_all_texture()
	
	if is_disabled :
		disable_texture.visible = true
	else :
		normal_texture.visible = true

func reset_all_texture():
	if tween != null :
		tween.kill()
	
	normal_texture.visible = false
	active_texture.visible = false
	disable_texture.visible = false
	select_indicator.visible = false
