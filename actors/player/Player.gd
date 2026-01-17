# Player.gd - Zelda-style top-down player controller
# 8-direction movement using WASD, Arrow Keys, or Left Stick
# Interacts with Area2D stations when pressing E/Space/A(gamepad) near them

extends CharacterBody2D

# Movement speed in pixels per second
@export var speed: float = 120.0

# Reference to the nearest interactable object (set by Interactable areas)
var nearby_interactable: Node = null

func _ready() -> void:
	# Add to player group for detection by building entrances
	add_to_group("player")

func _physics_process(_delta: float) -> void:
	# Get input direction using custom actions (WASD, Arrows, Left Stick)
	# Input.get_vector handles normalization automatically
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Apply movement
	velocity = input_dir * speed
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	# Handle interaction when E/Space/A is pressed and something is nearby
	if event.is_action_pressed("interact") and nearby_interactable:
		nearby_interactable.interact()

# Called by Interactable areas when player enters their detection zone
func set_nearby_interactable(node: Node) -> void:
	nearby_interactable = node

# Called by Interactable areas when player exits their detection zone
func clear_nearby_interactable(node: Node) -> void:
	if nearby_interactable == node:
		nearby_interactable = null
