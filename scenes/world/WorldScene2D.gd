# WorldScene2D.gd - Main 2D world hub (The Sanctuary)
# Displays player info in top-left, manages World Log UI overlay in bottom-left.
# Player can walk around and interact with philosophy stations using E key.
#
# Stations:
# - Stone (DISCIPLINE): steadfastness, repetition
# - Mirror (CLARITY): self-knowledge, honesty
# - Gate (COURAGE): facing fear, crossing thresholds

extends Node2D

# UI node references - World Log panel
@onready var log_text: Label = $UI/LogPanel/LogVBox/LogTextLabel
@onready var visit_count: Label = $UI/LogPanel/LogVBox/VisitCountLabel

# UI node references - Player Info panel
@onready var name_label: Label = $UI/PlayerInfoPanel/InfoVBox/NameLabel
@onready var archetype_label: Label = $UI/PlayerInfoPanel/InfoVBox/ArchetypeLabel
@onready var vow_label: Label = $UI/PlayerInfoPanel/InfoVBox/VowLabel

func _ready() -> void:
	# Add to world_log group so Interactable can notify us
	add_to_group("world_log")

	# Set scene type in GameState
	GameState.current_scene_type = GameState.SceneType.WORLD

	# Display player info from GameState
	var data: Dictionary = GameState.current_player_data
	name_label.text = data.get("name", "Wanderer")
	archetype_label.text = data.get("archetype", "Unknown")
	vow_label.text = "\"" + data.get("vow", "") + "\""

	# Initialize log display
	update_log()

# Called by Interactable stations via call_group("world_log", "update_log")
func update_log() -> void:
	# Update log text
	if GameState.last_log_text.is_empty():
		log_text.text = "Explore the sanctuary..."
	else:
		log_text.text = GameState.last_log_text

	# Update visit counts
	var v: Dictionary = GameState.station_visits
	visit_count.text = "Apothecary: %d | Archivist: %d | Gatekeeper: %d" % [v.apothecary, v.archivist, v.gatekeeper]

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_F5:
			GameState.DEBUG_boost_all_trust()
			update_log()
