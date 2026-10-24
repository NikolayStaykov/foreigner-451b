extends Node

var value: float
@export var min_value: float
@export var max_value: float
@export var step: float

signal value_changed(value: float)

func _ready() -> void:
	pass

func _on_decrease_button_pressed() -> void:
	if value - step >= min_value:
		value-=step
		%value_label.text = str(value)
		value_changed.emit(value)


func _on_increase_button_pressed() -> void:
	if value + step <= max_value:
		value+=step
		%value_label.text = str(value)
		value_changed.emit(value)

func set_value_external(new_value: float):
	value = new_value
	%value_label.text = str(value)
