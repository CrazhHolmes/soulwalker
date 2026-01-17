# WorldScene.gd
# The Sanctuary - a hub for reflection and preparation before venturing into the world.
# Contains three stations, each representing a core philosophical pillar:
#
# THE STONE (Discipline)
#   - Steadfastness, repetition, commitment
#   - "What you repeat, you become."
#
# THE MIRROR (Clarity)
#   - Self-knowledge, honesty, seeing truth
#   - "Name what you see. That is the first step."
#
# THE GATE (Courage)
#   - Facing fear, taking action, crossing thresholds
#   - "The only way out is through."
#
# Each station offers sensory grounding text and optional affirmations.
# Text cycles based on visit count to provide variety without randomness.

extends Control

# Stone texts - Discipline station
# Sensory: ground the player in physical reality
# Affirmation: reinforce the virtue of steadfastness
const STONE_TEXTS: Dictionary = {
	"sensory": [
		"The stone is cold and unyielding beneath your palm.",
		"Centuries of hands have worn a smooth groove into its surface.",
		"It does not move. It does not need to."
	],
	"affirmation": [
		"You are learning to be unmoved by what does not matter.",
		"Discipline is not rigidity. It is choosing your shape.",
		"What you repeat, you become."
	]
}

# Mirror texts - Clarity station
# Sensory: invite self-observation
# Affirmation: encourage honest self-knowledge
const MIRROR_TEXTS: Dictionary = {
	"sensory": [
		"Your reflection wavers, then settles.",
		"The mirror shows only what is. Nothing more.",
		"For a moment, you see yourself clearly."
	],
	"affirmation": [
		"Clarity asks nothing of you but honesty.",
		"Name what you see. That is the first step.",
		"The fog lifts when you stop running."
	]
}

# Gate texts - Courage station
# Sensory: evoke the threshold, the unknown
# Affirmation: normalize fear while encouraging action
const GATE_TEXTS: Dictionary = {
	"sensory": [
		"The gate stands open, darkness beyond.",
		"Wind pushes through from the other side.",
		"Something waits. It always has."
	],
	"affirmation": [
		"Courage is not fearlessness. It is moving anyway.",
		"You have stood here before. You will stand here again.",
		"The only way out is through."
	]
}

# Archetype-specific greetings - personalized ritual to ground the player
const GREETINGS: Dictionary = {
	"Warrior": "Steel yourself, %s. The path awaits.",
	"Mage": "The unseen reveals itself, %s.",
	"Rogue": "Move silent, %s. Trust your instincts.",
	"Cleric": "The light walks with you, %s."
}

# UI node references - player info
@onready var title_label: Label = $CenterContainer/VBoxContainer/TitleLabel
@onready var player_info_label: Label = $CenterContainer/VBoxContainer/PlayerInfoLabel
@onready var greeting_label: Label = $CenterContainer/VBoxContainer/GreetingLabel

# UI node references - station buttons
@onready var stone_button: Button = $CenterContainer/VBoxContainer/StationsContainer/StoneButton
@onready var mirror_button: Button = $CenterContainer/VBoxContainer/StationsContainer/MirrorButton
@onready var gate_button: Button = $CenterContainer/VBoxContainer/StationsContainer/GateButton

# UI node references - world log
@onready var log_text_label: Label = $CenterContainer/VBoxContainer/WorldLogPanel/LogVBoxContainer/LogTextLabel
@onready var visit_count_label: Label = $CenterContainer/VBoxContainer/WorldLogPanel/LogVBoxContainer/VisitCountLabel

# UI node references - proceed button
@onready var proceed_button: Button = $CenterContainer/VBoxContainer/ProceedButton

func _ready() -> void:
	# Set scene type in GameState
	GameState.current_scene_type = GameState.SceneType.WORLD

	# Get player data
	var player_name: String = GameState.current_player_data["name"]
	var archetype: String = GameState.current_player_data["archetype"]
	var vow: String = GameState.current_player_data["vow"]

	# Display player info in single line
	player_info_label.text = "%s | %s | \"%s\"" % [player_name, archetype, vow]

	# Display archetype-specific greeting
	if GREETINGS.has(archetype):
		greeting_label.text = GREETINGS[archetype] % player_name
	else:
		greeting_label.text = ""

	# Connect station buttons - each passes its station key
	stone_button.pressed.connect(_on_station_pressed.bind("stone"))
	mirror_button.pressed.connect(_on_station_pressed.bind("mirror"))
	gate_button.pressed.connect(_on_station_pressed.bind("gate"))

	# Update log display with any existing data
	_update_log_display()

# Called when any station button is pressed
func _on_station_pressed(station: String) -> void:
	# Select the appropriate text pool based on station
	var text_pool: Dictionary
	var theme: String = station

	match station:
		"stone":
			text_pool = STONE_TEXTS
		"mirror":
			text_pool = MIRROR_TEXTS
		"gate":
			text_pool = GATE_TEXTS
		_:
			return

	# Get current visit count to cycle through texts deterministically
	var visit_count: int = GameState.station_visits[station]

	# Pick sensory line using visit count modulo array size
	var sensory_array: Array = text_pool["sensory"]
	var sensory_index: int = visit_count % sensory_array.size()
	var sensory_text: String = sensory_array[sensory_index]

	# Build full text, starting with sensory
	var full_text: String = sensory_text

	# Add affirmation if enabled
	if GameState.affirmations_enabled:
		var affirmation_array: Array = text_pool["affirmation"]
		var affirmation_index: int = visit_count % affirmation_array.size()
		var affirmation_text: String = affirmation_array[affirmation_index]
		full_text += "\n\n" + affirmation_text

	# Log the interaction to GameState
	GameState.log_station(station, theme, full_text)

	# Update the display
	_update_log_display()

# Updates the World Log panel with current GameState data
func _update_log_display() -> void:
	# Set log text
	if GameState.last_log_text.is_empty():
		log_text_label.text = "No interactions yet."
	else:
		log_text_label.text = GameState.last_log_text

	# Set visit counts
	var stone_visits: int = GameState.station_visits["stone"]
	var mirror_visits: int = GameState.station_visits["mirror"]
	var gate_visits: int = GameState.station_visits["gate"]
	visit_count_label.text = "Visits - Stone: %d | Mirror: %d | Gate: %d" % [stone_visits, mirror_visits, gate_visits]
