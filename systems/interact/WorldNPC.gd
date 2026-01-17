# WorldNPC.gd - High-level NPC script for world encounters
# Supports tier-based dialogue and awareness levels

extends Area2D

@export var character_id: String = "civilian_A"
@export var npc_name: String = "Citizen"
@export var awareness_tier: int = 0
@export var character_theme: String = "COMPLIANCE"

# Visual references
@onready var prompt_label = $PromptLabel
@onready var sprite = $Sprite2D

var player_nearby: bool = false
var dialogue_count: int = 0

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	prompt_label.visible = false
	
func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("interact"):
		speak()

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_nearby = true
		prompt_label.visible = true
		prompt_label.text = "[E] Speak"

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_nearby = false
		prompt_label.visible = false
		hide_dialogue()

func speak():
	# Decide category based on how many times we've chatted
	var category = "greeting"
	if dialogue_count > 0:
		category = "subtext"
	if dialogue_count > 2:
		category = "breach"
		
	var text = DialogueManager.get_line(character_id, awareness_tier, category)
	
	# Apply NLP framing if tier matches
	if awareness_tier < 2:
		text = DialogueManager.apply_nlp_frame(text, "acceptance")
	
	show_dialogue(text)
	dialogue_count += 1

func show_dialogue(text: String):
	var root = get_tree().current_scene
	if root.has_method("show_dialogue"):
		root.show_dialogue(text)
	# Alternatively, if it's a world scene with a log:
	if root.has_method("update_log"):
		GameState.last_log_text = text
		GameState.last_theme = character_theme
		root.update_log()

func hide_dialogue():
	var root = get_tree().current_scene
	if root.has_method("hide_dialogue"):
		root.hide_dialogue()

func reset_dialogue():
	dialogue_count = 0
