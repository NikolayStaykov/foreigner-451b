extends OptionButton
var last_focused_index: int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	select(get_item_index(GlobalVars.resolution.split("x")[1] as int))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_item_focused(index: int) -> void:
	pass # Replace with function body.
