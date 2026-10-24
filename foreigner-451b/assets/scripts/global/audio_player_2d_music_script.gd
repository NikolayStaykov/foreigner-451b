extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.volume_db = GlobalVars.music_volume * 10 - 5 * 10
	GlobalVars.music_volume_changed.connect(update_volume)

func update_volume() -> void:
	self.volume_db = GlobalVars.music_volume * 10 - 5 * 10
