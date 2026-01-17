# InteriorMerchant.gd - Merchant NPC inside interior scenes
# Handles dialogue and interactions inside buildings
# Uses dialogue-driven logging - only logs after meaningful dialogue completion

extends Area2D

# Station identifier for GameState tracking
@export var station_key: String = "apothecary"

# Theme name
@export var theme: String = "FOLK MAGIC"

# NPC role within the building
@export var npc_role: String = "merchant"  # merchant, assistant, guardian, etc.

# Room location in multi-level buildings
@export var room_name: String = "Main Hall"

# Greeting lines - shown first time or randomly
@export var greeting_lines: Array[String] = []

# Sensory lines - atmospheric descriptions
@export var sensory_lines: Array[String] = []

# Affirmation lines - deeper dialogue
@export var affirmation_lines: Array[String] = []

# Service lines - what they offer
@export var service_lines: Array[String] = []

# Revelation lines - triggered at trust thresholds
@export var revelation_lines: Array[String] = []

# Reference to the prompt label child node
@onready var prompt_label: Label = $PromptLabel

# Track interaction state
var player_nearby: bool = false
var current_dialogue_stage: int = 0
var dialogue_in_progress: bool = false

# Dialogue stages
enum DialogueStage {
	GREETING,
	SENSORY,
	AFFIRMATION,
	SERVICE,
	REVELATION,
	COMPLETE
}

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	if prompt_label:
		prompt_label.visible = false

func _process(_delta: float) -> void:
	if player_nearby and Input.is_action_just_pressed("interact"):
		interact()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		player_nearby = true
		if prompt_label:
			prompt_label.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		player_nearby = false
		if prompt_label:
			prompt_label.visible = false
		# Hide dialogue when player walks away
		var parent = get_parent()
		if parent.has_method("hide_dialogue"):
			parent.hide_dialogue()
		# Don't reset dialogue - player can continue where they left off

func interact() -> void:
	dialogue_in_progress = true
	var trust_level = GameState.get_trust_level(station_key)
	
	# Try to get high-quality narrative from DialogueManager first
	var category = ""
	match current_dialogue_stage:
		DialogueStage.GREETING: category = "greeting"
		DialogueStage.SENSORY: category = "subtext"
		DialogueStage.AFFIRMATION, DialogueStage.SERVICE, DialogueStage.REVELATION: category = "breach"
		DialogueStage.COMPLETE: category = "breach"
	
	var external_text = DialogueManager.get_line(station_key, trust_level, category)
	
	# Build dialogue based on stage and trust
	var text: String = ""
	var dialogue_node: String = ""
	
	# Use external text if it's not a generic fallback
	if external_text != "...":
		text = external_text
		# Advance stages logic
		match current_dialogue_stage:
			DialogueStage.GREETING: 
				current_dialogue_stage = DialogueStage.SENSORY
				dialogue_node = "greeting"
			DialogueStage.SENSORY: 
				current_dialogue_stage = DialogueStage.AFFIRMATION
				dialogue_node = "sensory"
			DialogueStage.AFFIRMATION: 
				current_dialogue_stage = DialogueStage.SERVICE
				dialogue_node = "memory_revealed"
			DialogueStage.SERVICE: 
				current_dialogue_stage = DialogueStage.REVELATION
				dialogue_node = "service_provided"
			DialogueStage.REVELATION, DialogueStage.COMPLETE:
				current_dialogue_stage = DialogueStage.COMPLETE
				dialogue_node = "ritual_complete"
	else:
		# Fallback to hardcoded lines in scene
		match current_dialogue_stage:
			DialogueStage.GREETING:
				if greeting_lines.size() > 0:
					text = greeting_lines[randi() % greeting_lines.size()]
				dialogue_node = "greeting"
				current_dialogue_stage = DialogueStage.SENSORY
				
			DialogueStage.SENSORY:
				if sensory_lines.size() > 0:
					text = sensory_lines[randi() % sensory_lines.size()]
				dialogue_node = "sensory"
				current_dialogue_stage = DialogueStage.AFFIRMATION
				
			DialogueStage.AFFIRMATION:
				if affirmation_lines.size() > 0:
					text = affirmation_lines[randi() % affirmation_lines.size()]
				dialogue_node = "memory_revealed"
				current_dialogue_stage = DialogueStage.SERVICE
				
			DialogueStage.SERVICE:
				if service_lines.size() > 0:
					text = service_lines[randi() % service_lines.size()]
				dialogue_node = "service_provided"
				current_dialogue_stage = DialogueStage.REVELATION
				
			DialogueStage.REVELATION:
				if trust_level >= 3 and revelation_lines.size() > 0:
					text = revelation_lines[randi() % revelation_lines.size()]
					dialogue_node = "trust_earned"
				else:
					var all_lines: Array[String] = []
					all_lines.append_array(affirmation_lines)
					all_lines.append_array(service_lines)
					if all_lines.size() > 0:
						text = all_lines[randi() % all_lines.size()]
					dialogue_node = "reflection"
				current_dialogue_stage = DialogueStage.COMPLETE
				
			DialogueStage.COMPLETE:
				var all_deep_lines: Array[String] = []
				all_deep_lines.append_array(affirmation_lines)
				all_deep_lines.append_array(service_lines)
				if trust_level >= 3:
					all_deep_lines.append_array(revelation_lines)
				if all_deep_lines.size() > 0:
					text = all_deep_lines[randi() % all_deep_lines.size()]
				dialogue_node = "continued"

	# Final logging and display
	if dialogue_node in ["memory_revealed", "service_provided", "trust_earned", "ritual_complete"]:
		GameState.store_dialogue_pending(station_key, theme, text)
		GameState.log_visit_only_after_dialogue_complete(station_key, dialogue_node)
	else:
		GameState.store_dialogue_pending(station_key, theme, text)
		
	show_dialogue_text(text)


func show_dialogue_text(text: String) -> void:
	var parent = get_parent()
	if parent.has_method("show_dialogue"):
		parent.show_dialogue(text)

# Reset dialogue for a fresh conversation (called when re-entering building)
func reset_dialogue() -> void:
	current_dialogue_stage = DialogueStage.GREETING
	dialogue_in_progress = false

# Get the current stage name for UI display
func get_dialogue_stage_name() -> String:
	match current_dialogue_stage:
		DialogueStage.GREETING: return "Greeting"
		DialogueStage.SENSORY: return "Observation"
		DialogueStage.AFFIRMATION: return "Reflection"
		DialogueStage.SERVICE: return "Offering"
		DialogueStage.REVELATION: return "Revelation"
		DialogueStage.COMPLETE: return "Communion"
	return "Unknown"

