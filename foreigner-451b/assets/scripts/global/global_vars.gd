extends Node

#settings 
var language: String = "english"
var sound_effects_volume: float = 3
var music_volume: float = 5
var resolution: String = "1920x1080"

#signals for settings change
signal sound_effects_volume_changed
signal music_volume_changed

func set_sound_effects_volume(value: float) -> void:
	sound_effects_volume = value
	sound_effects_volume_changed.emit()
	
func set_music_volume(value: float) -> void: 
	music_volume = value
	music_volume_changed.emit()
