# ExitDoor.gd - Handles exiting from interior scenes back to the world
# Attach to Area2D nodes at interior doors

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
	if player_in_range and Input.is_action_just_pressed("interact"):
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
	# Get return scene from transition data
	var data = SceneTransition.get_transition_data()
	var return_scene = data.get("return_scene", "res://scenes/world/WorldScene2D.tscn")
	
	# Return to world
	SceneTransition.transition_to(return_scene)
