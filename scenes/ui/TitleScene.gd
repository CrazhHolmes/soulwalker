# TitleScene.gd
# Main menu/title screen - entry point for the game.
# Provides Start and Quit options, initializes GameState on start.

extends Control

@onready var start_btn: Button = $StartButton
@onready var quit_btn: Button = $QuitButton

func _ready() -> void:
	# Set scene type in GameState
	GameState.current_scene_type = GameState.SceneType.MENU

	# Connect button signals
	start_btn.pressed.connect(_on_start_pressed)
	quit_btn.pressed.connect(_on_quit_pressed)

func _on_start_pressed() -> void:
	# Initialize fresh game state before starting
	GameState.new_game()
	SceneLoader.goto("res://scenes/ui/CharacterCreation.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
