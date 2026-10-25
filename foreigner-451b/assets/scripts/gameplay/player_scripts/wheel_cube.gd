extends Node

@onready var main_body: CharacterBody3D
@export var cube_node: Node3D
@export var move_sound_effect: AudioStreamPlayer3D

var animation_player: AnimationPlayer
const SPEED: float = 5.0
var move_dir: int = 0
var speed_applied: bool = false

func _ready() -> void:
	animation_player = cube_node.get_children().filter(func(node): return node is AnimationPlayer)[0]
	main_body = get_parent()

func _physics_process(delta: float) -> void:
	#print(main_body.velocity.x)
	if not main_body.is_on_floor():
		main_body.velocity += main_body.get_gravity() * delta
		if speed_applied: 
			stop_move()
	else: 
		handle_keyboard_input()
		if move_dir == -1:
			animation_player.play_backwards("move")
		elif move_dir == 1:
			animation_player.play("move")
		else: 
			animation_player.pause()
	main_body.move_and_slide()
		
func handle_keyboard_input() -> void: 
	if Input.is_action_just_pressed("ui_right"):
		start_move_right()
	elif Input.is_action_just_pressed("ui_left"):
		start_move_left()
	elif Input.is_action_just_released("ui_right") and move_dir == 1:
		stop_move()
	elif Input.is_action_just_released("ui_left") and move_dir == -1:
		stop_move()
		
func handle_mouse_input(input: InputEventMouseButton) -> void: 
	if not input: 
		return
	if input.pressed == false:
		stop_move()
	elif input.button_index == 1:
		start_move_right()
	elif input.button_index == 2:
		start_move_left()
	pass

func _on_area_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	handle_mouse_input(event as InputEventMouseButton)
	
func start_move_right() -> void: 
	move_dir = 1
	main_body.velocity.x += 1 * SPEED
	move_sound_effect.play()
	speed_applied = true

func start_move_left() -> void: 
	move_dir = -1
	main_body.velocity.x += -1 * SPEED
	move_sound_effect.play()
	speed_applied = true

func stop_move() -> void: 
	main_body.velocity.x -= SPEED * move_dir
	move_dir = 0
	move_sound_effect.stop()
	speed_applied = false
