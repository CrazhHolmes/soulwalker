# InteriorMerchant.gd - Enhanced Merchant/NPC script with Currency Support
extends Area2D

@export var station_key: String = ""
@export var theme: String = "STANDARD"

@onready var prompt_label = $PromptLabel
@onready var dialogue_panel = get_parent().get_node_or_null("UI/DialoguePanel")
@onready var dialogue_label = get_parent().get_node_or_null("UI/DialoguePanel/VBox/DialogueLabel")

@onready var choice_menu = get_parent().get_node_or_null("UI/ChoiceMenu")

var player_nearby: bool = false
var is_interacting: bool = false
var time_passed: float = 0.0

@onready var sprite: Node2D = get_node_or_null("Sprite2D")
@onready var sprite_alt: Node2D = get_node_or_null("Sprite")

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	if prompt_label:
		prompt_label.visible = false
	if choice_menu:
		choice_menu.visible = false
	time_passed = randf() * 10.0

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_nearby = true
		if prompt_label:
			prompt_label.visible = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_nearby = false
		if prompt_label:
			prompt_label.visible = false
		hide_dialogue()

func _process(delta):
	time_passed += delta
	_update_idle_animation()
	
	if player_nearby and Input.is_action_just_pressed("interact") and not is_interacting:
		interact()

func _update_idle_animation():
	var s = sprite if sprite else sprite_alt
	if s:
		var breath = sin(time_passed * 2.0) * 0.02
		s.scale.y = 1.0 + breath
		s.scale.x = 1.0 - breath * 0.5

func interact():
	is_interacting = true
	_set_player_input(false)
	
	DialogueManager.current_npc = self
	var trust = GameState.get_trust_level(station_key)
	
	# Get the greeting data (now could be an object with text and choices)
	var data = DialogueManager.get_data(station_key, trust, "greeting")
	
	show_dialogue(data.get("text", "..."))
	
	if data.has("choices"):
		_show_choices(data["choices"])

func _show_choices(choices: Array):
	if not choice_menu: return
	
	# Clear old choices
	for child in choice_menu.get_node("VBox").get_children():
		child.queue_free()
	
	for choice in choices:
		var btn = Button.new()
		btn.text = choice["text"]
		btn.pressed.connect(_on_choice_selected.bind(choice))
		choice_menu.get_node("VBox").add_child(btn)
	
	choice_menu.visible = true
	# Focus first button for controller
	if choice_menu.get_node("VBox").get_child_count() > 0:
		choice_menu.get_node("VBox").get_child(0).grab_focus()

func _on_choice_selected(choice_data: Dictionary):
	choice_menu.visible = false
	show_dialogue(choice_data.get("response", "Very well."))
	
	# Handle specific choice results (like opening a shop or gaining trust)
	if choice_data.get("action") == "open_shop":
		_show_shop()
	
	await get_tree().create_timer(2.0).timeout
	hide_dialogue()

func _show_shop():
	# Placeholder for shop UI integration
	pass

func show_dialogue(text: String):
	if dialogue_label:
		dialogue_label.text = text
	if dialogue_panel:
		dialogue_panel.visible = true
	
	GameState.last_log_text = text
	GameState.last_theme = theme
	
	var root = get_tree().current_scene
	if root.has_method("update_log"):
		root.update_log()

func hide_dialogue():
	if dialogue_panel:
		dialogue_panel.visible = false
	if choice_menu:
		choice_menu.visible = false
	is_interacting = false
	_set_player_input(true)

func _set_player_input(enabled: bool):
	var player = get_tree().get_first_node_in_group("player")
	if player and player.has_method("set_input_enabled"):
		player.set_input_enabled(enabled)
