# CharacterCreation.gd
# Character creation screen - allows player to enter name, select archetype, and choose a vow.
# Validates input and saves to GameState before transitioning to WorldScene.

extends Control

# Available character archetypes
const ARCHETYPES: Array[String] = ["Warrior", "Mage", "Rogue", "Cleric"]

# Available vows - personal commitments that define the player's journey
const VOWS: Array[String] = [
	"I finish what I start",
	"I face what I fear",
	"I move with intent"
]

# Current selection indices
var current_archetype_index: int = 0
var current_vow_index: int = 0

# UI node references - archetype selection
@onready var name_input: LineEdit = $CenterContainer/VBoxContainer/NameInput
@onready var archetype_label: Label = $CenterContainer/VBoxContainer/ArchetypeSelector/ArchetypeLabel
@onready var prev_btn: Button = $CenterContainer/VBoxContainer/ArchetypeSelector/PrevButton
@onready var next_btn: Button = $CenterContainer/VBoxContainer/ArchetypeSelector/NextButton

# UI node references - vow selection
@onready var vow_label: Label = $CenterContainer/VBoxContainer/VowSelector/VowLabel
@onready var vow_prev_btn: Button = $CenterContainer/VBoxContainer/VowSelector/VowPrevButton
@onready var vow_next_btn: Button = $CenterContainer/VBoxContainer/VowSelector/VowNextButton

# UI node references - confirm
@onready var confirm_btn: Button = $CenterContainer/VBoxContainer/ConfirmButton

func _ready() -> void:
	# Set scene type in GameState
	GameState.current_scene_type = GameState.SceneType.CHARACTER_CREATION

	# Connect archetype button signals
	prev_btn.pressed.connect(_on_prev_pressed)
	next_btn.pressed.connect(_on_next_pressed)

	# Connect vow button signals
	vow_prev_btn.pressed.connect(_on_vow_prev_pressed)
	vow_next_btn.pressed.connect(_on_vow_next_pressed)

	# Connect confirm button
	confirm_btn.pressed.connect(_on_confirm_pressed)

	# Initialize displays
	_update_archetype_display()
	_update_vow_display()

# Navigate to previous archetype
func _on_prev_pressed() -> void:
	current_archetype_index -= 1
	if current_archetype_index < 0:
		current_archetype_index = ARCHETYPES.size() - 1
	_update_archetype_display()

# Navigate to next archetype
func _on_next_pressed() -> void:
	current_archetype_index += 1
	if current_archetype_index >= ARCHETYPES.size():
		current_archetype_index = 0
	_update_archetype_display()

# Update the archetype label to show current selection
func _update_archetype_display() -> void:
	archetype_label.text = ARCHETYPES[current_archetype_index]

# Navigate to previous vow
func _on_vow_prev_pressed() -> void:
	current_vow_index -= 1
	if current_vow_index < 0:
		current_vow_index = VOWS.size() - 1
	_update_vow_display()

# Navigate to next vow
func _on_vow_next_pressed() -> void:
	current_vow_index += 1
	if current_vow_index >= VOWS.size():
		current_vow_index = 0
	_update_vow_display()

# Update the vow label to show current selection
func _update_vow_display() -> void:
	vow_label.text = VOWS[current_vow_index]

# Confirm character creation and proceed to world
func _on_confirm_pressed() -> void:
	var player_name: String = name_input.text.strip_edges()

	# Use default name if empty
	if player_name.is_empty():
		player_name = "Adventurer"

	# Save player data to GameState
	GameState.set_player(player_name, ARCHETYPES[current_archetype_index])
	GameState.set_vow(VOWS[current_vow_index])

	# Transition to 2D world scene
	SceneLoader.goto("res://scenes/world/WorldScene2D.tscn")
