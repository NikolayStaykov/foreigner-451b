extends Node

@onready var main_body: RigidBody3D
@export var cube_node: Node3D
@export var move_sound_effect: AudioStreamPlayer3D
@export var red_light: OmniLight3D
@export var green_light: OmniLight3D

var animation_player: AnimationPlayer
const SPEED: float = 1500.0
var move_dir: int = 0
var last_input_type: int = 0 # 0 - none, 1 - mouse, 2 - keyboard
var mouse_right_held: bool = false 
var mouse_left_held: bool = false
var last_delta: float

func _ready() -> void:
	animation_player = cube_node.get_children().filter(func(node): return node is AnimationPlayer)[0]
	main_body = get_parent()

func _physics_process(delta: float) -> void:
	if snappedf(main_body.linear_velocity.y,0.01) != 0:
		stop_move()
	else: 
		last_delta = delta
		if last_input_type != 1:
			handle_keyboard_input()
		if last_input_type != 2:
			handle_mouse_input()
		if move_dir == -1:
			animation_player.play_backwards("move")
		elif move_dir == 1:
			animation_player.play("move")
		else: 
			animation_player.pause()
	hanlde_lights()
		
func handle_keyboard_input() -> void: 
	if Input.is_key_pressed(GlobalVars.wheel_cube_move_right_key):
		last_input_type = 2
		move_right()
	elif Input.is_key_pressed(GlobalVars.wheel_cube_move_left_key):
		last_input_type = 2
		move_left()
	elif !Input.is_key_pressed(GlobalVars.wheel_cube_move_right_key) and move_dir == 1:
		last_input_type = 0
		stop_move()
	elif !Input.is_key_pressed(GlobalVars.wheel_cube_move_left_key) and move_dir == -1:
		last_input_type = 0
		stop_move()
		
func handle_mouse_input() -> void: 
	if mouse_left_held:
		last_input_type = 1
		move_right()
	elif mouse_right_held:
		last_input_type = 1
		move_left()
	elif !mouse_left_held and move_dir == 1:
		last_input_type = 0
		stop_move()
	elif !mouse_right_held and move_dir == -1:
		last_input_type = 0
		stop_move()

func _on_area_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	parse_mouse_input(event as InputEventMouseButton)
	
func parse_mouse_input(event: InputEventMouseButton) -> void:
	if not event: 
		return
	if event.button_index == 1:
		mouse_left_held = event.pressed
	elif event.button_index == 2:
		mouse_right_held = event.pressed
		
func move_right() -> void: 
	move_dir = 1
	main_body.apply_force(Vector3(SPEED * last_delta,0,0))
	if !move_sound_effect.playing:
		move_sound_effect.play()

func move_left() -> void: 
	move_dir = -1
	main_body.apply_force(Vector3(SPEED * last_delta * -1.0,0,0))
	if !move_sound_effect.playing:
		move_sound_effect.play()

func stop_move() -> void:
	move_dir = 0
	move_sound_effect.stop()

func _on_area_3d_mouse_exited() -> void:
	mouse_left_held = false
	mouse_right_held = false
	
func hanlde_lights() -> void: 
	red_light.visible = snappedf(main_body.linear_velocity.y,0.01) != 0
	green_light.visible = !red_light.visible
