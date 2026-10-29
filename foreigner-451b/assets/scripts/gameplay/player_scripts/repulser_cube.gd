extends Node3D

@onready var main_body: RigidBody3D
@export var cube_node: Node3D
@export var repulser_sound_effect: AudioStreamPlayer3D
@export var red_light: OmniLight3D
@export var green_light: OmniLight3D
@export var button: Key
@export var impact_area: Area3D

var animation_player: AnimationPlayer
var repulser_ready: bool = true
var cooldown: float = 2.5
var force_vector_y: float
var force_vector_x: float
var force: float = 10
var residual_force: float = 0
var force_fall_off: float = 2
var force_fall_off_time_step: float = 0.1
var air_force_multiplier: float = 1

func _ready() -> void:
	animation_player = cube_node.get_children().filter(func(node): return node is AnimationPlayer)[0]
	main_body = get_parent()
	force_vector_x = -1 * round(cos(rotation.z))
	force_vector_y = -1 * round( sin(rotation.z))
	impact_area.body_entered.connect(process_impact_area_collision)
	

func execute_action() -> void:
	repulser_ready = false
	red_light.visible = true
	green_light.visible = false
	repulser_sound_effect.play()
	animation_player.play("Icosphere|IcosphereAction",-1,3)
	impact_area.monitoring = true
	get_tree().create_timer(0.1,false).connect("timeout",func(): impact_area.monitoring = false)
	main_body.apply_impulse(Vector3(force * force_vector_x,force * force_vector_y,0))
	get_tree().create_timer(cooldown, false).connect("timeout", reset_cooldown)

func reset_cooldown() -> void:
	repulser_ready = true
	red_light.visible = false
	green_light.visible = true
	pass

func _physics_process(delta: float) -> void:
	if Input.is_key_pressed(button) and repulser_ready:
		execute_action()


func _on_clickable_area_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	parse_click_event(event as InputEventMouseButton)
	pass
	
func parse_click_event(event: InputEventMouseButton) -> void:
	if not event: 
		return
	if event.button_index == 1 and event.pressed and repulser_ready:
		execute_action()

func process_impact_area_collision(body) -> void:
	if body is not RigidBody3D:
		return
	body = body as RigidBody3D
	#body.apply_force(Vector3(force * force_vector_x * -1,force * force_vector_y * -1,0))
	if body is Blastable:
		body.accept_blast()
	body.linear_velocity.x += force * force_vector_x * -1
	body.linear_velocity.y += force * force_vector_y * -1
