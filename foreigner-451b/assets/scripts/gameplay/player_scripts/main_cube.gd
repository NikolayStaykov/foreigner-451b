extends RigidBody3D

var player_in_base: bool = false 
@export var build_menu: PanelContainer

func _ready() -> void:
	linear_damp = 1
	EventBus.player_entered.connect(func(): player_in_base = true)
	EventBus.player_left.connect(func(): player_in_base = false)

func _physics_process(delta: float) -> void:
	print(player_in_base)
	if linear_velocity.y < 0:
		apply_force(Vector3(0,-10,0))
	if player_in_base and Input.is_action_just_pressed("tab"):
		build_menu.visible = !build_menu.visible
