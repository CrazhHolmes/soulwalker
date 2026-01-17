# TitleScene.gd
# Main menu/title screen - entry point for the game.
# Provides Start and Quit options, initializes GameState on start.

extends Control

@onready var start_btn: Button = $VBox/StartButton
@onready var quit_btn: Button = $VBox/QuitButton
@onready var redaction_bar = $VBox/Label/RedactionBar
@onready var glitch_overlay = $GlitchOverlay

func _ready() -> void:
	# Set scene type in GameState
	GameState.current_scene_type = GameState.SceneType.MENU
	
	# Connect button signals
	start_btn.pressed.connect(_on_start_pressed)
	quit_btn.pressed.connect(_on_quit_pressed)
	
	# Ensure controller navigation works by grabbing initial focus
	start_btn.grab_focus()
	
	# Subtle fade-in for the UI
	modulate.a = 0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.0)
	
	_animate_title()

func _input(event: InputEvent) -> void:
	# Explicitly handle 'X' (Cross) button on controller for focused buttons
	if event.is_action_pressed("interact"):
		var focused = get_viewport().gui_get_focus_owner()
		if focused is Button and focused.is_visible_in_tree():
			focused.pressed.emit()

func _animate_title():
	while true:
		await get_tree().create_timer(randf_range(3.0, 6.0)).timeout
		if not is_inside_tree(): break
		
		# Redaction flicker
		redaction_bar.visible = true
		glitch_overlay.material.set_shader_parameter("intensity", 0.6)
		await get_tree().create_timer(0.2).timeout
		redaction_bar.visible = false
		glitch_overlay.material.set_shader_parameter("intensity", 0.2)
		
		# Pulsing glow on Start text
		var tween = create_tween()
		tween.tween_property(start_btn, "modulate", Color(1.5, 1.5, 2.0), 0.6)
		tween.tween_property(start_btn, "modulate", Color.WHITE, 0.6)

func _on_start_pressed() -> void:
	# Intense glitch on confirm
	glitch_overlay.material.set_shader_parameter("intensity", 1.0)
	await get_tree().create_timer(0.4).timeout
	
	# Initialize fresh game state
	GameState.new_game()
	# Transition to character creation
	SceneTransition.transition_to("res://scenes/ui/CharacterCreation.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
