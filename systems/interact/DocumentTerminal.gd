# DocumentTerminal.gd - Handles the interaction with the Vault's document terminal

extends Area2D

@onready var prompt_label = $PromptLabel
var player_nearby = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	prompt_label.visible = false

func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("interact"):
		open_terminal()

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_nearby = true
		prompt_label.visible = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_nearby = false
		prompt_label.visible = false

func open_terminal():
	var vault = get_tree().current_scene
	if vault.has_method("open_document_grid"):
		vault.open_document_grid()
