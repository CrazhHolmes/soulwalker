# SceneTransition.gd - Handles smooth scene transitions with fade effects
# Autoload as "SceneTransition" to use globally
#
# Usage:
#   SceneTransition.transition_to("res://scenes/interiors/ApothecaryInterior.tscn")
#   SceneTransition.transition_to_with_data("res://path.tscn", {"spawn": "door"})

extends CanvasLayer

# Transition state
var is_transitioning: bool = false
var transition_data: Dictionary = {}

# References
@onready var fade_rect: ColorRect = $FadeRect

func _ready() -> void:
	# Start fully transparent
	fade_rect.color = Color(0, 0, 0, 0)
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

# Transition to a new scene with optional data
func transition_to(scene_path: String) -> void:
	transition_to_with_data(scene_path, {})

# Transition with custom data (e.g., spawn point info)
func transition_to_with_data(scene_path: String, data: Dictionary) -> void:
	if is_transitioning:
		return
	
	is_transitioning = true
	transition_data = data
	
	# Fade to black
	var tween = create_tween()
	tween.tween_property(fade_rect, "color:a", 1.0, 0.3)
	await tween.finished
	
	# Change scene
	var err = get_tree().change_scene_to_file(scene_path)
	if err != OK:
		push_error("SceneTransition: Failed to load scene: " + scene_path + " (Error: " + str(err) + ")")
		# Fade back in immediately on failure so player isn't stuck in blackness
		var tween_fail = create_tween()
		tween_fail.tween_property(fade_rect, "color:a", 0.0, 0.3)
		is_transitioning = false
		return
	
	# Wait a frame for scene to load
	await get_tree().process_frame
	
	# Fade back in
	var tween_in = create_tween()
	tween_in.tween_property(fade_rect, "color:a", 0.0, 0.3)
	await tween_in.finished
	
	is_transitioning = false

# Get data passed during transition
func get_transition_data() -> Dictionary:
	return transition_data

# Quick fade out (for dramatic moments)
func fade_out(duration: float = 0.5) -> void:
	var tween = create_tween()
	tween.tween_property(fade_rect, "color:a", 1.0, duration)
	await tween.finished

# Quick fade in
func fade_in(duration: float = 0.5) -> void:
	var tween = create_tween()
	tween.tween_property(fade_rect, "color:a", 0.0, duration)
	await tween.finished
