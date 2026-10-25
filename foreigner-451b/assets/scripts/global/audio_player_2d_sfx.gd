extends AudioStreamPlayer2D

func _ready() -> void:
	self.volume_db = GlobalVars.sound_effects_volume * 10 - 5 * 10
	GlobalVars.sound_effects_volume_changed.connect(update_volume)

func update_volume() -> void: 
	self.volume_db = GlobalVars.sound_effects_volume * 10 - 5 * 10
