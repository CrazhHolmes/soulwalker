# InteriorBase.gd - Base script for all interior scenes
# Handles common functionality like spawn points and UI display

extends Node2D

# Merchant info for UI display
@export var merchant_name: String = "Merchant"
@export var merchant_theme: String = "UNKNOWN"

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
	var player = $Player
	var spawn = $SpawnPoint
	if player and spawn:
		player.position = spawn.position

# Called by InteriorMerchant when player interacts
func show_dialogue(text: String) -> void:
	if dialogue_label and dialogue_panel:
		dialogue_label.text = text
		dialogue_panel.visible = true

# Hide dialogue (called after delay or player moves away)
func hide_dialogue() -> void:
	if dialogue_panel:
		dialogue_panel.visible = false
