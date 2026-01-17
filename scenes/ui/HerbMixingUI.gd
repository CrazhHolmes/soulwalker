# HerbMixingUI.gd - The memory recovery minigame for the Apothecary
# Players combine herbs to reveal "Memory Fragments"

extends Control

signal minigame_finished(success, result_text)

# Database of herbs and their properties
const HERBS = {
	"SAGE": {"name": "Purifying Sage", "property": "Clarity", "color": Color(0.5, 0.7, 0.5)},
	"GOLDENSEAL": {"name": "Goldenseal", "property": "Preservation", "color": Color(0.8, 0.7, 0.3)},
	"YARROW": {"name": "White Yarrow", "property": "Binding", "color": Color(0.9, 0.9, 0.8)},
	"NIGHTSHADE": {"name": "Bitter Nightshade", "property": "Void", "color": Color(0.3, 0.2, 0.4)},
	"MUGWORT": {"name": "Mugwort", "property": "Dreaming", "color": Color(0.4, 0.5, 0.4)}
}

# Combination recipes for memories
const RECIPES = {
	"SAGE+GOLDENSEAL": {
		"id": "mem_first_vow",
		"name": "Essence of the First Vow",
		"description": "A flash of white light. You remember speaking the words for the first time."
	},
	"SAGE+YARROW": {
		"id": "mem_sanctuary_origin",
		"name": "Breath of the Sanctuary",
		"description": "You see the stones of the Sanctuary rising from the mist, guided by hands unseen."
	},
	"MUGWORT+SAGE": {
		"id": "mem_astral_drift",
		"name": "Dream-Walker's Draught",
		"description": "You feel your weight vanish. You remember looking down at your own sleeping form."
	},
	"NIGHTSHADE+YARROW": {
		"id": "mem_the_severing",
		"name": "The Bitter Binding",
		"description": "A sharp pain in your chest. You remember the moment your connection to the source was cut."
	}
}

var selected_herbs: Array[String] = []

@onready var herb_list = $CenterContainer/MainPanel/VBox/HerbGrid
@onready var selected_list = $CenterContainer/MainPanel/VBox/SelectedHBox/SelectedList
@onready var result_label = $CenterContainer/MainPanel/VBox/ResultLabel
@onready var mix_button = $CenterContainer/MainPanel/VBox/Buttons/MixButton

func _ready() -> void:
	# Hide by default
	visible = false
	setup_herb_grid()
	update_ui()

func setup_herb_grid() -> void:
	for herb_id in HERBS:
		var btn = Button.new()
		btn.text = HERBS[herb_id]["name"]
		btn.custom_minimum_size = Vector2(120, 40)
		btn.tooltip_text = "Property: " + HERBS[herb_id]["property"]
		btn.pressed.connect(_on_herb_selected.bind(herb_id))
		herb_list.add_child(btn)

func _on_herb_selected(herb_id: String) -> void:
	if selected_herbs.size() < 2:
		selected_herbs.append(herb_id)
		update_ui()

func _on_clear_pressed() -> void:
	selected_herbs.clear()
	result_label.text = "Select two herbs to begin the distillation..."
	update_ui()

func update_ui() -> void:
	# Update selected herbs visual
	for child in selected_list.get_children():
		child.queue_free()
	
	for herb_id in selected_herbs:
		var label = Label.new()
		label.text = HERBS[herb_id]["name"]
		label.modulate = HERBS[herb_id]["color"]
		selected_list.add_child(label)
	
	mix_button.disabled = selected_herbs.size() < 2

func _on_mix_pressed() -> void:
	if selected_herbs.size() < 2: return
	
	# Sort to ensure order doesn't matter (A+B == B+A)
	selected_herbs.sort()
	var key = "+".join(selected_herbs)
	
	if RECIPES.has(key):
		var recipe = RECIPES[key]
		result_label.text = "SUCCESS: " + recipe["name"] + "\n\n" + recipe["description"]
		result_label.modulate = Color(0.6, 1.0, 0.7)
		
		# Record the memory
		GameState.record_memory("apothecary", recipe["id"])
		GameState.increase_trust("apothecary", 2)
		
		# Trigger the visual reflection
		MemoryReflection.trigger(get_tree(), recipe["name"], recipe["description"])
		
		# Trigger dialogue completion if this is the first success
		GameState.log_visit_only_after_dialogue_complete("apothecary", "memory_revealed")

	else:
		result_label.text = "The mixture turns a murky grey. A bitter failure.\nTry different properties."
		result_label.modulate = Color(0.9, 0.4, 0.4)
		GameState.increase_trust("apothecary", 1) # Still get some trust for trying

func open_minigame() -> void:
	selected_herbs.clear()
	result_label.text = "Select two herbs to begin the distillation..."
	result_label.modulate = Color.WHITE
	update_ui()
	visible = true
	# Animation could go here

func _on_close_pressed() -> void:
	visible = false
	minigame_finished.emit(false, "Finished mixing.")
