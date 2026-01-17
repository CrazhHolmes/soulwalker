# RoomTransition.gd - Handles moving between levels/rooms within an interior
# Can be a stairwell, ladder, or doorway

extends Area2D

# Target location (scene path or internal room name)
@export var target_scene: String = ""
@export var target_room: String = "Basement"

# Position to spawn player at in target
@export var spawn_position: Vector2 = Vector2.ZERO

# Floor number (used for trust-based unlocking)
@export var floor_num: int = 1

# Reference to prompt label
@onready var prompt_label: Label = $PromptLabel

var player_nearby: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	if prompt_label:
		prompt_label.visible = false
		prompt_label.text = "[E] Enter " + target_room

func _process(_delta: float) -> void:
	if player_nearby and Input.is_action_just_pressed("interact") and not SceneTransition.is_transitioning:
		attempt_transition()

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

func attempt_transition() -> void:
	# Check if floor is unlocked
	var merchant_key = get_merchant_key()
	if floor_num > 1 and not GameState.is_floor_unlocked(merchant_key, floor_num):
		show_locked_message()
		return
	
	perform_transition()

func perform_transition() -> void:
	if not target_scene.is_empty():
		# Switch to a different scene file
		var data = {
			"return_scene": get_tree().current_scene.scene_file_path,
			"spawn_position": spawn_position,
			"from_interior": true
		}
		SceneTransition.transition_to_with_data(target_scene, data)
	else:
		# Just move player within current scene if it's a large multi-room layout
		var player = get_tree().get_first_node_in_group("player")
		if player and spawn_position != Vector2.ZERO:
			# Fade effect for internal transition
			SceneTransition.fade_out()
			await get_tree().create_timer(0.3).timeout
			player.position = spawn_position
			var parent = get_parent()
			if parent.has_method("set_current_room"):
				parent.set_current_room(target_room)
			SceneTransition.fade_in()

func get_merchant_key() -> String:
	var root = get_tree().current_scene
	if root.has_method("get_merchant_key"):
		return root.get_merchant_key()
	# Fallback/Default
	if "Apothecary" in root.name: return "apothecary"
	if "Archivist" in root.name: return "archivist"
	if "Gatekeeper" in root.name: return "gatekeeper"
	return ""

func show_locked_message() -> void:
	var root = get_tree().current_scene
	if root.has_method("show_dialogue"):
		root.show_dialogue("This area is locked. You must earn more trust first.")
