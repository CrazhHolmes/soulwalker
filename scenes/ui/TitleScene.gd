# TitleScene.gd
# Main menu/title screen - entry point for the game.
# Provides Start and Quit options, initializes GameState on start.

extends Control

@onready var start_btn: Button = $VBox/StartButton
@onready var quit_btn: Button = $VBox/QuitButton

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

func _on_start_pressed() -> void:
	# Initialize fresh game state
	GameState.new_game()
	# Transition to character creation
	SceneTransition.transition_to("res://scenes/ui/CharacterCreation.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
