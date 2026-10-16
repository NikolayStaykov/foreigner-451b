extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.volume_db = GlobalVars.sound_effects_volume
