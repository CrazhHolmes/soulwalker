# BuildingEntrance.gd - Handles building entry/exit zones
# Attach to Area2D nodes at building doors
#
# Shows prompt when player is nearby, transitions to interior on E press
# Saves player position so they return to the same spot when exiting

extends Area2D

# Scene to load when entering
@export_file("*.tscn") var interior_scene: String = ""

# Data to pass to the interior scene
@export var entrance_id: String = "main"

# Prompt text
@export var prompt_text: String = "[E] Enter"

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
		enter_building()

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

func enter_building() -> void:
	if interior_scene.is_empty():
		push_warning("BuildingEntrance: No interior scene set!")
		return
	
	# Find the player to save their position
	var player = get_tree().get_first_node_in_group("player")
	var player_pos = Vector2.ZERO
	if player:
		player_pos = player.global_position
	
	# Pass data about which entrance was used and where to return
	var data = {
		"from_entrance": entrance_id,
		"return_scene": get_tree().current_scene.scene_file_path,
		"return_position": player_pos,
		"building_position": global_position
	}
	
	SceneTransition.transition_to_with_data(interior_scene, data)
