extends Node3D

@onready var main_body: RigidBody3D
@export var red_light: OmniLight3D
@export var green_light: OmniLight3D
@export var particles: GPUParticles3D
@export var button: Key

var fuel: float = 10
var max_fuel: float = 10
var fuel_regen_rate: float = 0.5
var burn_rate: float = 3
var thrust: float = 1600
var force_vector_y: float
var force_vector_x: float
var mouse_button_pressed: bool = false

func _ready() -> void:
	force_vector_x = -1 * round(cos(rotation.z))
	force_vector_y = -1 * round( sin(rotation.z)) / 2
	main_body = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if (Input.is_key_pressed(button) or mouse_button_pressed) and fuel > 0:
		particles.emitting = true
		main_body.apply_force(Vector3(thrust * force_vector_x * delta, thrust * force_vector_y * delta,0))
		fuel -= burn_rate * delta
	elif fuel <= 0:
		green_light.visible = false
		red_light.visible = true
		particles.emitting = false
		get_tree().create_timer(5, false).connect("timeout", func():
			fuel = max_fuel
			red_light.visible = false
			green_light.visible = true
		)
	elif fuel > 0 and fuel < max_fuel:
		particles.emitting = false
		fuel += fuel_regen_rate * delta


func _on_click_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	parse_click_event(event as InputEventMouseButton)
	pass
	
func parse_click_event(event: InputEventMouseButton) -> void:
	if not event: 
		return
	if event.button_index == 1:
		mouse_button_pressed = event.pressed
		


func _on_click_area_mouse_exited() -> void:
	mouse_button_pressed = false 
