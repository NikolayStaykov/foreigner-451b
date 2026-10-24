extends Control

func _ready() -> void:
	%sound_effects_value_control.set_value_external(GlobalVars.sound_effects_volume)
	%music_volume_value_control.set_value_external(GlobalVars.music_volume)


func _on_options_button_pressed() -> void:
	%main_panel_container.visible = false
	%options_container.visible = true

func _on_res_dropdown_menu_item_selected(index: int) -> void:
	GlobalVars.resolution = %res_dropdown_menu.get_item_text(index)
	print(GlobalVars.resolution)
	DisplayServer.window_set_size(Vector2i(GlobalVars.resolution.split("x")[0] as int, GlobalVars.resolution.split("x")[1] as int ))


func _on_fullscreen_check_box_check_box_value_changed(value: bool) -> void:
	if value:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else: 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_sound_effects_value_control_value_changed(value: float) -> void:
	GlobalVars.set_sound_effects_volume(value)


func _on_music_volume_value_control_value_changed(value: float) -> void:
	GlobalVars.set_music_volume(value)


func _on_options_back_button_pressed() -> void:
	%main_panel_container.visible = true
	%options_container.visible = false


func _on_quit_button_pressed() -> void:
	get_tree().quit()
