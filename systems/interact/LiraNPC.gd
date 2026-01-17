# LiraNPC.gd - Specialized NPC script for 'The Childhood Friend'
# Handles the memory redaction consequence check.

extends Area2D

@export var prompt_text: String = "[E] Speak"
@onready var prompt_label = $PromptLabel
@onready var sprite = $Sprite2D

var player_nearby: bool = false
var time_passed: float = 0.0

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	if prompt_label:
		prompt_label.visible = false
	time_passed = randf() * 10.0

func _process(delta):
	time_passed += delta
	if sprite:
		var breath = sin(time_passed * 2.0) * 0.02
		sprite.scale.y = 1.0 + breath
		sprite.scale.x = 1.0 - breath * 0.5
		
	if player_nearby and Input.is_action_just_pressed("interact"):
		speak()

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_nearby = true
		if prompt_label:
			prompt_label.visible = true
			prompt_label.text = prompt_text

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_nearby = false
		if prompt_label:
			prompt_label.visible = false

func speak():
	var text = ""
	
	# THE CORE CONSEQUENCE CHECK
	if GameState.get_flag("memory_redacted_childhood_friend"):
		text = "I... I don't think we've met. Are you with the Office?"
	else:
		text = "Hey! There you are. I counted—that stone skip was at least five bounces. You're getting better!"
	
	_show_dialogue(text)

func _show_dialogue(text: String):
	var root = get_tree().current_scene
	
	# Update World Log if in main world
	if root.has_method("update_log"):
		GameState.last_log_text = text
		GameState.last_theme = "MEMORIES"
		root.update_log()
	
	# Or show popup if root supports it
	if root.has_method("show_dialogue"):
		root.show_dialogue(text)
