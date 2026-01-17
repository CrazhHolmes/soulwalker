# MirrorPortal.gd - Handles the Gatekeeper's astral mirror mechanics
# Mirrors can show different "Memory Versions" and act as portals

extends Area2D

signal mirror_viewed(memory_type)
signal mirror_entered(target_mirror_id)

enum MemoryType { TRUE, FABRICATED, SUPPRESSED, PARALLEL }

@export var mirror_id: String = "mirror_A"
@export var target_mirror_id: String = ""
@export var memory_type: MemoryType = MemoryType.TRUE
@export var memory_content: String = "A true reflection of what was."
@export var is_correct_path: bool = true

@onready var prompt_label = $PromptLabel
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer

var player_nearby: bool = false
var is_viewing: bool = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	prompt_label.visible = false
	
	# Apply shader if not already done in editor
	if sprite and sprite.material:
		sprite.material.set_shader_parameter("distortion_strength", 0.02)

func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("interact"):
		if not is_viewing:
			look_closer()
		else:
			enter_mirror()

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_nearby = true
		prompt_label.visible = true
		prompt_label.text = "[E] Look Closer"

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_nearby = false
		prompt_label.visible = false
		if is_viewing:
			stop_viewing()

func look_closer():
	is_viewing = true
	prompt_label.text = "[E] Enter Reflection"
	
	# Show memory snippet in scene UI
	var sanctum = get_tree().current_scene
	if sanctum.has_method("show_memory_overlay"):
		sanctum.show_memory_overlay(memory_content, memory_type)
	
	mirror_viewed.emit(memory_type)
	
	# Visual flare
	if anim:
		anim.play("focus")

func stop_viewing():
	is_viewing = false
	prompt_label.text = "[E] Look Closer"
	
	var sanctum = get_tree().current_scene
	if sanctum.has_method("hide_memory_overlay"):
		sanctum.hide_memory_overlay()

func enter_mirror():
	if target_mirror_id.is_empty():
		return
		
	# Find target mirror in scene
	var target = get_tree().current_scene.find_child(target_mirror_id, true, false)
	if target:
		mirror_entered.emit(target_mirror_id)
		
		# Fade effect
		SceneTransition.fade_out(0.2)
		await get_tree().create_timer(0.2).timeout
		
		# Teleport player to target mirror's position (slightly offset so they don't immediately re-trigger)
		var player = get_tree().get_first_node_in_group("player")
		if player:
			player.position = target.global_position + Vector2(0, 40)
			
		SceneTransition.fade_in(0.2)
		stop_viewing()
		
		# Update sanctum puzzle state
		var sanctum = get_tree().current_scene
		if sanctum.has_method("_on_mirror_traversed"):
			sanctum._on_mirror_traversed(mirror_id, is_correct_path)
