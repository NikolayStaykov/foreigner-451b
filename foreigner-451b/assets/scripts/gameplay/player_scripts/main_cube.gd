extends RigidBody3D

func _ready() -> void:
	linear_damp = 1

func _physics_process(delta: float) -> void:
	if linear_velocity.y < 0:
		apply_force(Vector3(0,-10,0))
