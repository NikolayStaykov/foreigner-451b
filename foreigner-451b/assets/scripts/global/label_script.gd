extends Label

@export var label_name: String

func _ready() -> void:
	self.text = FileAccess.open('res://assets/language/' + GlobalVars.language + '/' + label_name + '.txt', FileAccess.READ).get_as_text().trim_suffix("\n")
	return
