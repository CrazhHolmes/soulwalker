# Interactable.gd - Base class for philosophy stations
# Handles proximity detection, E prompt display, and interaction logging
#
# Each station represents a philosophical pillar:
# - Stone (DISCIPLINE): steadfastness, repetition, commitment
# - Mirror (CLARITY): self-knowledge, honesty, seeing truth
# - Gate (COURAGE): facing fear, taking action, crossing thresholds
#
# When the player enters the Area2D, shows a prompt.
# When the player presses E, logs the interaction to GameState.

extends Area2D

# Station identifier for GameState tracking
@export var station_key: String = "stone"

# Theme name displayed in logs
@export var theme: String = "DISCIPLINE"

# Sensory grounding lines - cycle based on visit count
@export var sensory_lines: Array[String] = []

# Affirmation lines - shown if GameState.affirmations_enabled
@export var affirmation_lines: Array[String] = []

# Reference to the prompt label child node
@onready var prompt_label: Label = $PromptLabel

func _ready() -> void:
	# Connect body detection signals
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	# Hide prompt initially
	if prompt_label:
		prompt_label.visible = false

# Called when a body enters the interaction zone
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("set_nearby_interactable"):
		body.set_nearby_interactable(self)
		if prompt_label:
			prompt_label.visible = true

# Called when a body exits the interaction zone
func _on_body_exited(body: Node2D) -> void:
	if body.has_method("clear_nearby_interactable"):
		body.clear_nearby_interactable(self)
		if prompt_label:
			prompt_label.visible = false

# Called by the player when E is pressed
func interact() -> void:
	# Get current visit count for this station
	var visits: int = GameState.station_visits.get(station_key, 0)

	# Build interaction text starting with sensory line
	var text: String = ""
	if sensory_lines.size() > 0:
		text = sensory_lines[visits % sensory_lines.size()]

	# Add affirmation if enabled and available
	if GameState.affirmations_enabled and affirmation_lines.size() > 0:
		var affirmation: String = affirmation_lines[visits % affirmation_lines.size()]
		if not text.is_empty():
			text += "\n\n" + affirmation
		else:
			text = affirmation

	# Log the interaction to GameState (increments visit count)
	GameState.log_station(station_key, theme, text)

	# Notify any UI listening for log updates
	get_tree().call_group("world_log", "update_log")
