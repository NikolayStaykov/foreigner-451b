extends Node

func _ready() -> void:
	pass


func _on_options_button_pressed() -> void:
	%main_panel_container.visible = false
	%options_container.visible = true
