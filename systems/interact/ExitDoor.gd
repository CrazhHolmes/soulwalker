# ExitDoor.gd - Handles exiting from interior scenes back to the world
# Attach to Area2D nodes at interior doors
# Returns player to their saved position in the world

extends Area2D

# Prompt text
@export var prompt_text: String = "[E] Exit"

# Reference to prompt label
@onready var prompt_label: Label = $PromptLabel

# Track if player is in range
var player_in_range: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	if prompt_label:
		prompt_label.visible = false
		prompt_label.text = prompt_text

func _process(_delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact") and not SceneTransition.is_transitioning:
		exit_building()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		player_in_range = true
		if prompt_label:
			prompt_label.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		player_in_range = false
		if prompt_label:
			prompt_label.visible = false

func exit_building() -> void:
	# Get return data from transition
	var data = SceneTransition.get_transition_data()
	var return_scene = data.get("return_scene", "res://scenes/world/WorldScene2D.tscn")
	var return_pos = data.get("return_position", Vector2.ZERO)
	var building_pos = data.get("building_position", Vector2.ZERO)
	
	# Calculate exit position (slightly south of building door)
	var exit_pos = building_pos + Vector2(0, 30)
	if return_pos != Vector2.ZERO:
		exit_pos = return_pos
	
	# Pass the exit position back so the world can position the player
	var exit_data = {
		"spawn_position": exit_pos,
		"from_interior": true
	}
	
	SceneTransition.transition_to_with_data(return_scene, exit_data)
