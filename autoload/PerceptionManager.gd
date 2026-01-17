# PerceptionManager.gd - Manages world-warping effects based on GameState
extends CanvasLayer

@onready var color_rect = $SubViewportContainer/SubViewport/ColorRect
@onready var shader_rect = $ShaderOverlay

var target_intensity: float = 0.0
var current_intensity: float = 0.0

func _ready():
	# Create the shader overlay if it doesn't exist (though it should be in the scene)
	if shader_rect:
		shader_rect.material.set_shader_parameter("intensity", 0.0)

func _process(delta):
	# Calculate target intensity based on Doubt Marks and Recall Tokens
	var dm = GameState.doubt_marks
	var rt = GameState.recall_tokens
	
	# Formula: Doubts weigh more than Tokens
	# 5 Doubts = 0.5 intensity, 10 Tokens = 0.2 intensity
	target_intensity = clamp((dm * 0.1) + (rt * 0.02), 0.0, 1.0)
	
	# Smoothly interpolate intensity to avoid jarring jumps
	if current_intensity != target_intensity:
		current_intensity = lerp(current_intensity, target_intensity, delta * 2.0)
		if shader_rect:
			shader_rect.material.set_shader_parameter("intensity", current_intensity)
			
	# Optional: Play static sound / heartbeat if intensity is high
