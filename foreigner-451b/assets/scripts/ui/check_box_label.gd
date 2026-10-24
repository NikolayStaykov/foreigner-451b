extends Label

var value = false
signal check_box_value_changed(value: bool)

func _on_gui_input(event: InputEvent) -> void:
	parse_event(event as InputEventMouseButton)

func parse_event(event: InputEventMouseButton) -> void: 
	if event and event.button_index == 1 and event.pressed: 
			value = !value
			check_box_value_changed.emit(value)
			flip_content()

func flip_content() -> void: 
	if value:
		text = "[X]"
	else:
		text = "[ ]"
