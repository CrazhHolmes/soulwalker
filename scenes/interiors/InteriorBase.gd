# InteriorBase.gd - Base script for all interior scenes
# Handles common functionality like spawn points, UI display, and wall collisions
# Supports multi-room layouts with multiple levels (TARDIS-like larger interiors)

extends Node2D

# Merchant info for UI display
@export var merchant_name: String = "Merchant"
@export var merchant_theme: String = "UNKNOWN"

# Interior dimensions (larger than exterior suggests - TARDIS logic)
@export var interior_width: float = 800.0
@export var interior_height: float = 600.0

# Current room the player is in
var current_room: String = "Main Hall"

# UI references
@onready var merchant_name_label: Label = $UI/MerchantPanel/VBox/MerchantNameLabel
@onready var theme_label: Label = $UI/MerchantPanel/VBox/ThemeLabel
@onready var dialogue_label: Label = $UI/DialoguePanel/VBox/DialogueLabel
@onready var dialogue_panel: PanelContainer = $UI/DialoguePanel

func _ready() -> void:
	# Set scene type
	GameState.current_scene_type = GameState.SceneType.WORLD
	
	# Update UI
	if merchant_name_label:
		merchant_name_label.text = merchant_name
	if theme_label:
		theme_label.text = merchant_theme
	
	# Hide dialogue initially
	if dialogue_panel:
		dialogue_panel.visible = false
	
	# Position player at spawn point
	var player = get_node_or_null("Player")
	var spawn = get_node_or_null("SpawnPoint")
	if player and spawn:
		player.position = spawn.position
	
	# Set up camera limits for larger interiors
	if player:
		var camera = player.get_node_or_null("Camera2D")
		if camera:
			camera.limit_left = 0
			camera.limit_top = 0
			camera.limit_right = int(interior_width)
			camera.limit_bottom = int(interior_height)
	
	# Reset all NPC dialogues when entering building
	reset_all_npc_dialogues()

# Reset all NPC dialogues in this interior
func reset_all_npc_dialogues() -> void:
	# Find all NPCs in the scene and reset their dialogue
	for child in get_children():
		if child.has_method("reset_dialogue"):
			child.reset_dialogue()
		# Also check in room containers
		if child.name.ends_with("Room") or child.name.ends_with("Level"):
			for npc in child.get_children():
				if npc.has_method("reset_dialogue"):
					npc.reset_dialogue()

# Called by InteriorMerchant when player interacts
func show_dialogue(text: String) -> void:
	if dialogue_label and dialogue_panel:
		dialogue_label.text = text
		dialogue_panel.visible = true

# Hide dialogue (called after delay or player moves away)
func hide_dialogue() -> void:
	if dialogue_panel:
		dialogue_panel.visible = false

# Update current room display (called by room transition zones)
func set_current_room(room: String) -> void:
	current_room = room
	# Could update UI here if we add a room indicator

# Get all NPCs in this interior
func get_all_npcs() -> Array:
	var npcs = []
	for child in get_children():
		if child is Area2D and child.has_method("interact"):
			npcs.append(child)
		# Also check in room containers
		if child.name.ends_with("Room") or child.name.ends_with("Level"):
			for npc in child.get_children():
				if npc is Area2D and npc.has_method("interact"):
					npcs.append(npc)
	return npcs

func get_merchant_key() -> String:
	if "Apothecary" in name: return "apothecary"
	if "Archivist" in name: return "archivist"
	if "Gatekeeper" in name: return "gatekeeper"
	return merchant_name.to_lower().replace(" ", "_").replace("the_", "")


