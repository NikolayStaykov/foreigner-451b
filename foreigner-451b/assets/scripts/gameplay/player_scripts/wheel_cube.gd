extends Node

@onready var main_body: CharacterBody3D
@export var cube_node: Node3D
@export var move_sound_effect: AudioStreamPlayer3D

var animation_player: AnimationPlayer
const SPEED: float = 5.0
var perserved_velocity : float = 0
var move_dir: int = 0
var mouse_right_held: bool = false 
var mouse_left_held: bool = false 

func _ready() -> void:
	animation_player = cube_node.get_children().filter(func(node): return node is AnimationPlayer)[0]
	main_body = get_parent()

func _physics_process(delta: float) -> void:
	if not main_body.is_on_floor():
		main_body.velocity += main_body.get_gravity() * delta
		if move_dir != 0: 
			perserved_velocity = move_dir * SPEED
			stop_move()
			main_body.velocity.x += perserved_velocity
			lose_air_momentum()
	else: 
		if GlobalVars.keyboard_controls:
			handle_keyboard_input()
		else:
			handle_mouse_input()
		if move_dir == -1:
			animation_player.play_backwards("move")
		elif move_dir == 1:
			animation_player.play("move")
		else: 
			animation_player.pause()
	main_body.move_and_slide()
		
func handle_keyboard_input() -> void: 
	if Input.is_key_pressed(GlobalVars.wheel_cube_move_right_key) and move_dir == 0:
		start_move_right()
	elif Input.is_key_pressed(GlobalVars.wheel_cube_move_left_key) and move_dir == 0:
		start_move_left()
	elif !Input.is_key_pressed(GlobalVars.wheel_cube_move_right_key) and move_dir == 1:
		stop_move()
	elif !Input.is_key_pressed(GlobalVars.wheel_cube_move_left_key) and move_dir == -1:
		stop_move()
		
func handle_mouse_input() -> void: 
	if mouse_left_held and move_dir == 0:
		start_move_right()
	elif mouse_right_held and move_dir == 0:
		start_move_left()
	elif !mouse_left_held and move_dir == 1:
		stop_move()
	elif !mouse_right_held and move_dir == -1:
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
		
func start_move_right() -> void: 
	move_dir = 1
	main_body.velocity.x += 1 * SPEED
	move_sound_effect.play()

func start_move_left() -> void: 
	move_dir = -1
	main_body.velocity.x += -1 * SPEED
	move_sound_effect.play()

func stop_move() -> void: 
	main_body.velocity.x -= SPEED * move_dir
	move_dir = 0
	move_sound_effect.stop()


func _on_area_3d_mouse_exited() -> void:
	mouse_left_held = false
	mouse_right_held = false

func lose_air_momentum() -> void: 
	if main_body.is_on_floor():
		perserved_velocity = 0
		
	if perserved_velocity == 0: 
		return
		
	if perserved_velocity > 0:
		perserved_velocity -= 1
		main_body.velocity.x -= 1
	elif perserved_velocity < 0:
		perserved_velocity += 1
		main_body.velocity.x -= 1
	get_tree().create_timer(0.1,true).connect("Timeout",lose_air_momentum)
