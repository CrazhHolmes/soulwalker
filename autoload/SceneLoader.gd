extends Node

func goto(scene_path: String, data: Dictionary = {}) -> void:
	if not data.is_empty():
		get_tree().set_meta("next_scene_data", data)
	get_tree().change_scene_to_file(scene_path)

func take_scene_data() -> Dictionary:
	var d: Dictionary = {}
	if get_tree().has_meta("next_scene_data"):
		var meta_val = get_tree().get_meta("next_scene_data")
		if typeof(meta_val) == TYPE_DICTIONARY:
			d = meta_val
		get_tree().remove_meta("next_scene_data")
	return d
