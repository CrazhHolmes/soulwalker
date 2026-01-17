# GameState.gd
# Global game state manager - tracks current scene, player data, and game progression.
# Autoloaded as "GameState" to provide persistent state across scene changes.
#
# Also tracks station visits in the Sanctuary:
# - Apothecary = folk magic, herbs, physical artifacts
# - Archivist = secrets, documents, mind control
# - Gatekeeper = rituals, astral projection, gateways
#
# Vendor trust system tracks relationship with each merchant.

extends Node

# Scene type enum for tracking where the player currently is
enum SceneType { MENU, CHARACTER_CREATION, WORLD, COMBAT }

# Current scene the player is in
var current_scene_type: SceneType = SceneType.MENU

# Whether affirmations/ritual greetings are enabled
var affirmations_enabled: bool = true

# Player data dictionary - persists across scenes
var current_player_data: Dictionary = {
	"name": "",
	"archetype": "",
	"vow": "",
	"level": 1,
	"health": 100,
	"max_health": 100
}

# Station visit counts - tracks player engagement with each sanctuary station
var station_visits: Dictionary = {
	"apothecary": 0,
	"archivist": 0,
	"gatekeeper": 0
}

# Vendor trust levels - increases with each interaction
var vendor_trust: Dictionary = {
	"apothecary": 0,
	"archivist": 0,
	"gatekeeper": 0
}

# Last logged interaction text for display in World Log
var last_log_text: String = ""

# Theme of last interaction (sensory, affirmation, etc.)
var last_theme: String = ""

# Resets player data to defaults for a new game
func new_game() -> void:
	current_player_data = {
		"name": "",
		"archetype": "",
		"vow": "",
		"level": 1,
		"health": 100,
		"max_health": 100
	}
	# Reset station visits for new game
	station_visits = {
		"apothecary": 0,
		"archivist": 0,
		"gatekeeper": 0
	}
	# Reset vendor trust for new game
	vendor_trust = {
		"apothecary": 0,
		"archivist": 0,
		"gatekeeper": 0
	}
	last_log_text = ""
	last_theme = ""
	current_scene_type = SceneType.MENU

# Sets player name and archetype during character creation
func set_player(player_name: String, archetype: String) -> void:
	current_player_data["name"] = player_name
	current_player_data["archetype"] = archetype

# Sets the player's chosen vow
func set_vow(vow: String) -> void:
	current_player_data["vow"] = vow

# Logs a station interaction - increments visit count, builds trust, and stores the text
func log_station(station_key: String, theme: String, text: String) -> void:
	if station_visits.has(station_key):
		station_visits[station_key] += 1
	increase_trust(station_key)
	last_log_text = text
	last_theme = theme

# Increases trust with a vendor
func increase_trust(vendor: String, amount: int = 1) -> void:
	if vendor_trust.has(vendor):
		vendor_trust[vendor] += amount
