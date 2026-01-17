# MemoryReflection.gd - Visual effect for memory recovery
# Can be triggered from anywhere when a memory is found

extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var label = $CenterContainer/VBox/Label
@onready var desc = $CenterContainer/VBox/Description
@onready var animation_player = $AnimationPlayer

func _ready():
	color_rect.color.a = 0
	visible = false

func play_reflection(title: String, description: String):
	visible = true
	label.text = title
	desc.text = description
	
	# Play the visual sequence
	animation_player.play("reveal")
	await animation_player.animation_finished
	
	# Wait for player to read
	await get_tree().create_timer(4.0).timeout
	
	animation_player.play_backwards("reveal")
	await animation_player.animation_finished
	visible = false

# Static helper to trigger it easily
static func trigger(tree: SceneTree, title: String, description: String):
	var node = tree.root.get_node_or_null("MemoryReflection")
	if node:
		node.play_reflection(title, description)
