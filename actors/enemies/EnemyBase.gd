# EnemyBase.gd - Base class for all hostile entities
# Handles health, damage, and basic AI behavior

extends CharacterBody2D

class_name EnemyBase

@export var max_health: int = 50
@export var current_health: int = 50
@export var damage: int = 10
@export var speed: float = 80.0
@export var detection_radius: float = 200.0

var player: CharacterBody2D = null
var is_active: bool = false

@onready var sprite = $Sprite2D
@onready var detection_area = $DetectionArea

func _ready():
	current_health = max_health
	if detection_area:
		detection_area.body_entered.connect(_on_player_detected)
		detection_area.body_exited.connect(_on_player_lost)

func _physics_process(delta):
	if is_active and player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
		
		# Simple flipping based on direction
		if velocity.x > 0:
			sprite.flip_h = false
		elif velocity.x < 0:
			sprite.flip_h = true

func take_damage(amount: int):
	current_health -= amount
	print(name, " took ", amount, " damage. Health: ", current_health)
	
	# Flash red effect
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color.RED, 0.1)
	tween.tween_property(sprite, "modulate", Color.WHITE, 0.1)
	
	if current_health <= 0:
		die()

func die():
	print(name, " has been redacted.")
	queue_free()

func _on_player_detected(body):
	if body.is_in_group("player"):
		player = body
		is_active = true

func _on_player_lost(body):
	if body == player:
		player = null
		is_active = false
		velocity = Vector2.ZERO
