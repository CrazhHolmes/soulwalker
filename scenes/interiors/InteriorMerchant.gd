# InteriorMerchant.gd - Merchant NPC inside interior scenes
# Handles dialogue and interactions inside buildings

extends Area2D

# Station identifier for GameState tracking
@export var station_key: String = "apothecary"

# Theme name
@export var theme: String = "FOLK MAGIC"

# Greeting lines - shown first time or randomly
@export var greeting_lines: Array[String] = []

# Sensory lines - atmospheric descriptions
@export var sensory_lines: Array[String] = []

# Affirmation lines - deeper dialogue
@export var affirmation_lines: Array[String] = []

# Service lines - what they offer
@export var service_lines: Array[String] = []

# Reference to the prompt label child node
@onready var prompt_label: Label = $PromptLabel

# Track interaction state
var player_nearby: bool = false
var interaction_count: int = 0

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
		var parent = get_parent().get_parent()
		if parent.has_method("hide_dialogue"):
			parent.hide_dialogue()

func interact() -> void:
	interaction_count += 1
	
	# Build dialogue based on interaction count
	var text: String = ""
	
	# First interaction: greeting
	if interaction_count == 1 and greeting_lines.size() > 0:
		text = greeting_lines[randi() % greeting_lines.size()]
	# Second: sensory
	elif interaction_count == 2 and sensory_lines.size() > 0:
		text = sensory_lines[randi() % sensory_lines.size()]
	# Third+: mix of affirmations and services
	else:
		var all_lines: Array[String] = []
		all_lines.append_array(affirmation_lines)
		all_lines.append_array(service_lines)
		if all_lines.size() > 0:
			text = all_lines[randi() % all_lines.size()]
	
	# Log to GameState
	GameState.log_station(station_key, theme, text)
	
	# Display dialogue in the interior scene
	var parent = get_parent().get_parent()
	if parent.has_method("show_dialogue"):
		parent.show_dialogue(text)
