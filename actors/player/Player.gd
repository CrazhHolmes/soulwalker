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

var can_attack: bool = true
var attack_cooldown: float = 0.5
var attack_damage: int = 15

func _ready() -> void:
	add_to_group("player")
	attack_area.body_entered.connect(_on_attack_hit)

func _physics_process(_delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * speed
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and nearby_interactable:
		nearby_interactable.interact()
	
	if event.is_action_pressed("attack") and can_attack:
		perform_attack()

func perform_attack():
	can_attack = false
	attack_area.monitoring = true
	attack_visual.visible = true
	attack_visual.scale = Vector2.ZERO
	
	var tween = create_tween()
	tween.tween_property(attack_visual, "scale", Vector2.ONE, 0.1)
	tween.tween_property(attack_visual, "visible", false, 0.1).set_delay(0.1)
	
	await get_tree().create_timer(0.2).timeout
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
