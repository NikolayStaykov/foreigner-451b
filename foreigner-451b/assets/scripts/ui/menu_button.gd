extends Button

@export var label_name: String
@export var on_hover_sound: AudioStreamPlayer2D
@export var on_click_sound: AudioStreamPlayer2D
@export var on_hover_highlight_enabled: bool = true

func _ready() -> void:
	if not label_name:
		return
	self.text = FileAccess.open('res://assets/language/' + GlobalVars.language + '/' + label_name + '.txt', FileAccess.READ).get_as_text()

func _on_mouse_entered() -> void:
	if on_hover_highlight_enabled:
		self.text = '>' + self.text
		on_hover_sound.play()


func _on_mouse_exited() -> void:
	if on_hover_highlight_enabled:
		self.text = self.text.substr(1)


func _on_pressed() -> void:
	on_click_sound.play()
