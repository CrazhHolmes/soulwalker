# Player.gd - Zelda-style top-down player controller
# 8-direction movement using WASD, Arrow Keys, or Left Stick
# Interacts with Area2D stations when pressing E/Space/A(gamepad) near them

extends CharacterBody2D

# Movement speed in pixels per second
@export var speed: float = 120.0

# Reference to the nearest interactable object (set by Interactable areas)
var nearby_interactable: Node = null

@onready var attack_area = $AttackArea
@onready var attack_visual = $AttackVisual
@onready var sprite = $Sprite2D

var can_attack: bool = true
var attack_cooldown: float = 0.5
var attack_damage: int = 15

func _ready() -> void:
	add_to_group("player")
	attack_area.body_entered.connect(_on_attack_hit)
	_setup_appearance()

func _setup_appearance():
	var archetype = GameState.current_player_data.get("archetype", "Rogue")
	sprite.region_rect = _get_base_rect(archetype)
var input_enabled: bool = true

# Animation parameters
var time_passed: float = 0.0
var walk_bob_speed: float = 12.0
var walk_bob_amplitude: float = 4.0
var idle_bob_speed: float = 2.0
var idle_bob_amplitude: float = 0.02 # Scale based

# Frame-based animation
var current_anim_frame: int = 0
var anim_timer: float = 0.0
var frame_duration: float = 0.15 
var frame_order: Array = [0, 1, 0, 2] # 4-step walk cycle

func _physics_process(delta: float) -> void:
	if not input_enabled:
		velocity = Vector2.ZERO
		_update_animations(delta)
		return
		
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * speed
	move_and_slide()
	
	_update_animations(delta)

func _update_animations(delta: float) -> void:
	time_passed += delta
	var archetype = GameState.current_player_data.get("archetype", "Rogue")
	var base_rect = _get_base_rect(archetype)
	
	# Determine row based on direction
	var y_offset = 145 # FRONT
	if velocity.y < 0:
		y_offset = 395 # BACK
	elif abs(velocity.x) > abs(velocity.y):
		y_offset = 645 # SIDE
		
	if velocity.length() > 0:
		# WALKING ANIMATION (Frame stepping)
		anim_timer += delta
		if anim_timer >= frame_duration:
			anim_timer = 0
			current_anim_frame = (current_anim_frame + 1) % frame_order.size()
			
		var frame_step = frame_order[current_anim_frame] # 0, 1, 0, 2
		# ChatGPT sheet columns are roughly 250px apart
		sprite.region_rect = Rect2(base_rect.position.x + (frame_step * 250), y_offset, 185, 230)
		
		# Flip side view
		if y_offset == 645:
			sprite.flip_h = velocity.x < 0
		else:
			sprite.flip_h = false
			
		# Procedural bob
		var bob = sin(time_passed * walk_bob_speed) * walk_bob_amplitude
		sprite.position.y = bob
	else:
		# IDLE
		sprite.region_rect = Rect2(base_rect.position.x, y_offset, 185, 230)
		sprite.flip_h = false
		
		# Breathing
		var breath = sin(time_passed * idle_bob_speed) * idle_bob_amplitude
		sprite.scale.y = 0.3 * (1.0 + breath)
		sprite.scale.x = 0.3 * (1.0 - breath * 0.5)
		sprite.position.y = 0

func _get_base_rect(archetype: String) -> Rect2:
	# Horizontal start positions for archetypes
	match archetype:
		"Warrior": return Rect2(65, 145, 185, 230)
		"Mage": return Rect2(315, 145, 185, 230)
		"Rogue": return Rect2(565, 145, 185, 230)
		"Cleric": return Rect2(815, 145, 185, 230)
	return Rect2(65, 145, 185, 230) # Default

func _unhandled_input(event: InputEvent) -> void:
	if not input_enabled: return
	
	if event.is_action_pressed("interact") and nearby_interactable:
		nearby_interactable.interact()
	
	if event.is_action_pressed("attack") and can_attack:
		perform_attack()

func perform_attack():
	can_attack = false
	attack_area.monitoring = true
	attack_visual.visible = true
	attack_visual.scale = Vector2.ZERO
	
	# Lunge forward
	var move_dir = (get_global_mouse_position() - global_position).normalized()
	if velocity.length() > 0:
		move_dir = velocity.normalized()
	
	var lunge_tween = create_tween().set_parallel(true)
	lunge_tween.tween_property(sprite, "position", move_dir * 15.0, 0.1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	lunge_tween.tween_property(sprite, "scale", Vector2(1.2, 0.6) * 0.8, 0.1)
	
	# Lunge the whole body slightly
	var body_tween = create_tween()
	body_tween.tween_property(self, "velocity", move_dir * speed * 2.0, 0.05)
	
	var tween = create_tween()
	tween.tween_property(attack_visual, "scale", Vector2.ONE, 0.1)
	tween.tween_property(attack_visual, "visible", false, 0.1).set_delay(0.1)
	
	await get_tree().create_timer(0.15).timeout
	
	# Recovery
	var recover_tween = create_tween().set_parallel(true)
	recover_tween.tween_property(sprite, "position", Vector2.ZERO, 0.1)
	recover_tween.tween_property(sprite, "scale", Vector2.ONE * 0.8, 0.1)
	
	attack_area.monitoring = false
	
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true

func _on_attack_hit(body):
	if body.has_method("take_damage"):
		body.take_damage(attack_damage)

# Called by Interactable areas when player enters their detection zone
func set_nearby_interactable(node: Node) -> void:
	nearby_interactable = node

# Called by Interactable areas when player exits their detection zone
func clear_nearby_interactable(node: Node) -> void:
	if nearby_interactable == node:
		nearby_interactable = null

func apply_debuff(type: String, duration: float):
	print("Player: Applied debuff ", type, " for ", duration, "s")
	if type == "SCRUTINY":
		speed *= 0.5
		
		# Flash blue indicator
		modulate = Color(0.5, 0.5, 1.5)
		
		await get_tree().create_timer(duration).timeout
		speed = 120.0 # Reset to base
		modulate = Color.WHITE

func set_input_enabled(enabled: bool):
	input_enabled = enabled
	if not enabled:
		velocity = Vector2.ZERO
