# GatekeeperSanctum.gd - Managed the Astral Sanctum puzzle layer

extends "res://scenes/interiors/InteriorBase.gd"

@onready var memory_overlay = $UI/MemoryOverlay
@onready var memory_text = $UI/MemoryOverlay/VBox/Text
@onready var memory_type_label = $UI/MemoryOverlay/VBox/Type

var puzzle_sequence: Array = []
var required_sequence: Array = ["mirror_origin", "mirror_past", "mirror_truth"]
var puzzle_solved: bool = false

func _ready():
	super._ready()
	memory_overlay.visible = false
	
	# Connect mirrors
	for child in get_children():
		if child.has_signal("mirror_viewed"):
			child.mirror_viewed.connect(_on_mirror_viewed)
		if child.has_signal("mirror_entered"):
			child.mirror_entered.connect(_on_mirror_entered)

func show_memory_overlay(contentList: String, type: int):
	memory_text.text = contentList
	
	var type_name = "UNKNOWN"
	var type_color = Color.WHITE
	
	match type:
		0: # TRUE
			type_name = "TRUE MEMORY"
			type_color = Color(0.6, 1.0, 0.7)
		1: # FABRICATED
			type_name = "FABRICATED MEMORY"
			type_color = Color(1.0, 0.4, 0.4)
		2: # SUPPRESSED
			type_name = "SUPPRESSED MEMORY"
			type_color = Color(0.7, 0.4, 1.0)
		3: # PARALLEL
			type_name = "PARALLEL MEMORY"
			type_color = Color(0.4, 0.7, 1.0)
			
	memory_type_label.text = type_name
	memory_type_label.modulate = type_color
	memory_overlay.visible = true

func hide_memory_overlay():
	memory_overlay.visible = false

func _on_mirror_viewed(_type):
	# Could add atmospheric sounds here
	pass

func _on_mirror_traversed(id: String, is_correct: bool):
	if puzzle_solved: return
	
	if is_correct:
		if not id in puzzle_sequence:
			puzzle_sequence.append(id)
			check_puzzle_completion()
	else:
		# Reset on wrong path? Or just don't progress
		puzzle_sequence.clear()
		show_dialogue("The reflection rejects your path. The sequence shatters.")

func check_puzzle_completion():
	var all_correct = true
	for id in required_sequence:
		if id not in puzzle_sequence:
			all_correct = false
			break
			
	if all_correct:
		solve_puzzle()

func solve_puzzle():
	puzzle_solved = true
	GameState.increase_trust("gatekeeper", 5)
	GameState.log_visit_only_after_dialogue_complete("gatekeeper", "ritual_complete")
	
	# Visual reveal
	$ExitPortal.visible = true
	show_dialogue("The mirrors align. The path to the depths is revealed.")
	
	# Play success reflection
	MemoryReflection.trigger(get_tree(), "The Astral Alignment", "You see yourself reflected in infinite versions, but focus on the one that walks forward.")
