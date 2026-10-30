extends Area3D

class_name HomeBase

func _on_body_entered(body: Node3D) -> void:
	EventBus.player_entered.emit()


func _on_body_exited(body: Node3D) -> void:
	EventBus.player_left.emit()
