# RedactionConsole.gd - Terminal interaction for the Redaction Chamber
# Extends Area2D for proximity detection, opens the RedactionTerminal UI on interaction
#
# Place in ArchivistInterior near the back desk. When interacted with,
# this console opens the memory-editing terminal interface.

extends Area2D

@export var terminal_type: String = "MK-IV"
@export var prompt_text: String = "[E] Access Terminal"
@export var requires_clearance: int = 0  # Minimum trust level with archivist

# UI scene to instantiate when activated
const TERMINAL_SCENE = preload("res://scenes/ui/RedactionTerminal.tscn")

@onready var prompt_label: Label = $PromptLabel
@onready var terminal_visual: ColorRect = $TerminalVisual
@onready var screen_glow: ColorRect = $TerminalVisual/ScreenGlow

var player_nearby: bool = false
var terminal_instance: Control = null
var terminal_active: bool = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	if prompt_label:
		prompt_label.visible = false
		prompt_label.text = prompt_text

	# Animate the screen glow
	if screen_glow:
		_start_glow_animation()


func _process(_delta: float) -> void:
	if player_nearby and not terminal_active and Input.is_action_just_pressed("interact"):
		_activate_terminal()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby = true
		if prompt_label:
			prompt_label.visible = true

			# Check clearance requirement
			var trust = GameState.get_trust_level("archivist")
			if trust < requires_clearance:
				prompt_label.text = "[CLEARANCE INSUFFICIENT]"
			else:
				prompt_label.text = prompt_text


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby = false
		if prompt_label:
			prompt_label.visible = false


func _activate_terminal() -> void:
	# Check clearance
	var trust = GameState.get_trust_level("archivist")
	if trust < requires_clearance:
		_show_access_denied()
		return

	# Check if player has any Recall Tokens
	if GameState.recall_tokens <= 0:
		_show_insufficient_tokens()
		return

	terminal_active = true

	# Hide the interaction prompt
	if prompt_label:
		prompt_label.visible = false

	# Instance the terminal UI
	terminal_instance = TERMINAL_SCENE.instantiate()

	# Add to the scene's UI layer
	var ui_layer = get_tree().current_scene.get_node_or_null("UI")
	if ui_layer:
		ui_layer.add_child(terminal_instance)
	else:
		get_tree().current_scene.add_child(terminal_instance)

	# Connect to know when terminal is closed
	if terminal_instance.has_signal("task_completed"):
		terminal_instance.task_completed.connect(_on_terminal_closed)

	# Pause player movement (optional - depends on game design)
	_set_player_input_enabled(false)


func _on_terminal_closed() -> void:
	terminal_active = false

	# Clean up terminal instance
	if terminal_instance:
		terminal_instance.queue_free()
		terminal_instance = null

	# Re-enable player input
	_set_player_input_enabled(true)

	# Show prompt again if player still nearby
	if player_nearby and prompt_label:
		prompt_label.visible = true


func _show_access_denied() -> void:
	var root = get_tree().current_scene
	if root.has_method("show_dialogue"):
		root.show_dialogue("ACCESS DENIED: Your clearance level is insufficient.\nThe Archivist may grant access after further... cooperation.")


func _show_insufficient_tokens() -> void:
	var root = get_tree().current_scene
	if root.has_method("show_dialogue"):
		root.show_dialogue("TERMINAL INACTIVE: No Recall Tokens detected.\nCalibration requires cognitive currency.\nVisit a Calibration Specialist to contribute memories.")


func _set_player_input_enabled(enabled: bool) -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player and player.has_method("set_input_enabled"):
		player.set_input_enabled(enabled)


func _start_glow_animation() -> void:
	# Create a subtle pulsing glow effect on the terminal screen
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(screen_glow, "modulate:a", 0.3, 1.5).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(screen_glow, "modulate:a", 0.7, 1.5).set_ease(Tween.EASE_IN_OUT)
