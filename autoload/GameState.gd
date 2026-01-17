# GameState.gd
# Global game state manager - tracks current scene, player data, and game progression.
#
# Vendor trust system tracks relationship with each merchant.
# Dialogue-driven logging: visits only count after meaningful dialogue completion.

extends Node

# Scene type enum for tracking where the player currently is
enum SceneType { MENU, CHARACTER_CREATION, WORLD, COMBAT }

# Dialogue completion endpoints that trigger logging
const DIALOGUE_ENDPOINTS: Array[String] = [
	"purchase_complete",
	"memory_revealed",
	"trust_earned",
	"secret_shared",
	"ritual_complete",
	"service_provided"
]

# Current scene the player is in
var current_scene_type: SceneType = SceneType.MENU

# Player data dictionary - persists across scenes
var current_player_data: Dictionary = {
	"name": "",
	"archetype": "",
	"vow": "",
	"level": 1,
	"health": 100,
	"max_health": 100
}

# Station visit counts - only incremented after meaningful dialogue completion
var station_visits: Dictionary = {
	"apothecary": 0,
	"archivist": 0,
	"gatekeeper": 0
}

# Enhanced Vendor Trust & Progression
var vendor_trust: Dictionary = {
	"apothecary": {
		"level": 0,
		"floors_unlocked": 1,
		"memories_revealed": []
	},
	"archivist": {
		"level": 0,
		"floors_unlocked": 1,
		"memories_revealed": []
	},
	"gatekeeper": {
		"level": 0,
		"floors_unlocked": 1,
		"memories_revealed": []
	}
}

# Dialogue progress tracking
var dialogue_progress: Dictionary = {
	"apothecary": {"stage": 0, "last_node": "", "pending_log": ""},
	"archivist": {"stage": 0, "last_node": "", "pending_log": ""},
	"gatekeeper": {"stage": 0, "last_node": "", "pending_log": ""}
}

# Player Narrative Stats
var player_name: String = ""
var player_archetype: String = ""
var player_vow: String = ""
var player_max_health: int = 100
var player_current_health: int = 100

# Tri-Currency Framework (Economic Control)
var notarized_merits: int = 50  # NM (Controls the Body)
var recall_tokens: int = 0      # RT (Controls the Mind) - Rare
var witness_marks: int = 0      # WM (Controls Perception) - Social/Reputation
var doubt_marks: int = 0        # DM (Negative Perception) - Risky

# Narrative & Access State
var discovered_memories: Array[String] = []

# Last logged interaction text for display in World Log
var last_log_text: String = ""
var last_theme: String = ""

# Resets player data to defaults for a new game
func new_game() -> void:
	current_player_data = {
		"name": "", "archetype": "", "vow": "",
		"level": 1, "health": 100, "max_health": 100
	}
	player_name = ""
	player_archetype = ""
	player_vow = ""
	player_max_health = 100
	player_current_health = 100
	notarized_merits = 50
	recall_tokens = 0
	witness_marks = 0
	doubt_marks = 0
	discovered_memories = []
	station_visits = {"apothecary": 0, "archivist": 0, "gatekeeper": 0}
	vendor_trust = {
		"apothecary": {"level": 0, "floors_unlocked": 1, "memories_revealed": []},
		"archivist": {"level": 0, "floors_unlocked": 1, "memories_revealed": []},
		"gatekeeper": {"level": 0, "floors_unlocked": 1, "memories_revealed": []}
	}
	dialogue_progress = {
		"apothecary": {"stage": 0, "last_node": "", "pending_log": ""},
		"archivist": {"stage": 0, "last_node": "", "pending_log": ""},
		"gatekeeper": {"stage": 0, "last_node": "", "pending_log": ""}
	}
	last_log_text = ""
	last_theme = ""
	current_scene_type = SceneType.MENU

func set_player(player_name: String, archetype: String) -> void:
	current_player_data["name"] = player_name
	current_player_data["archetype"] = archetype
	print("GameState: Player set to ", player_name, " (", archetype, ")")

func set_vow(vow: String) -> void:
	current_player_data["vow"] = vow
	print("GameState: Vow set to ", vow)


# Stores pending dialogue text without logging immediately
func store_dialogue_pending(station_key: String, theme: String, text: String) -> void:
	if dialogue_progress.has(station_key):
		dialogue_progress[station_key]["pending_log"] = text
		last_theme = theme

# Only increment visit count after specific dialogue endpoints
func log_visit_only_after_dialogue_complete(vendor: String, dialogue_node: String = "final") -> void:
	if dialogue_node in DIALOGUE_ENDPOINTS or dialogue_node == "final":
		if station_visits.has(vendor):
			station_visits[vendor] += 1
			increase_trust(vendor, 1)
			
			# Apply pending log text to world log
			if dialogue_progress.has(vendor):
				var pending = dialogue_progress[vendor].get("pending_log", "")
				if not pending.is_empty():
					last_log_text = pending
				dialogue_progress[vendor]["pending_log"] = ""
				dialogue_progress[vendor]["stage"] += 1

# Increases trust level and handles progression unlocks
func increase_trust(vendor: String, amount: int = 1) -> void:
	if vendor_trust.has(vendor):
		vendor_trust[vendor]["level"] += amount
		
		# Auto-unlock floors based on trust (TARDIS logic)
		if vendor_trust[vendor]["level"] >= 5 and vendor_trust[vendor]["floors_unlocked"] < 2:
			unlock_floor(vendor, 2)
		if vendor_trust[vendor]["level"] >= 10 and vendor_trust[vendor]["floors_unlocked"] < 3:
			unlock_floor(vendor, 3)

func unlock_floor(vendor: String, floor_num: int) -> void:
	if vendor_trust.has(vendor):
		vendor_trust[vendor]["floors_unlocked"] = max(vendor_trust[vendor]["floors_unlocked"], floor_num)
		print("Unlocked floor ", floor_num, " for ", vendor)

func get_trust_level(vendor: String) -> int:
	if vendor_trust.has(vendor):
		return vendor_trust[vendor]["level"]
	return 0

func record_memory(vendor: String, memory_id: String) -> void:
	if vendor_trust.has(vendor) and not memory_id in vendor_trust[vendor]["memories_revealed"]:
		vendor_trust[vendor]["memories_revealed"].append(memory_id)

func is_floor_unlocked(vendor: String, floor_num: int) -> bool:
	if vendor_trust.has(vendor):
		return vendor_trust[vendor]["floors_unlocked"] >= floor_num
	return false

# DEBUG: Instantly boost trust to unlock all areas
func DEBUG_boost_all_trust() -> void:
	for vendor in vendor_trust.keys():
		increase_trust(vendor, 10)
	print("DEBUG: All trust boosted by 10. Floor 2 should be unlocked.")

