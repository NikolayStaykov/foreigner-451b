extends Node

@onready var main_body: CharacterBody3D
const SPEED = 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_body = get_parent()


func _physics_process(delta: float) -> void:
	if not main_body.is_on_floor():
		main_body.velocity += main_body.get_gravity() * delta
	else: 
		var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var direction := (main_body.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			main_body.velocity.x = direction.x * SPEED
			main_body.velocity.z = direction.z * SPEED
		else:
			main_body.velocity.x = move_toward(main_body.velocity.x, 0, SPEED)
			main_body.velocity.z = move_toward(main_body.velocity.z, 0, SPEED)
	main_body.move_and_slide()
