# biography_entry.gd - Resource for memory data
extends Resource
class_name BiographyEntry

@export var entry_id: String = ""
@export var display_name: String = ""
@export var category: String = "PERSONAL"
@export var weight: String = "MODERATE"
@export var rt_cost: int = 10

@export_multiline var pre_redaction_text: String = ""
@export_multiline var post_redaction_text: String = ""

@export var key_consequence_flag: String = ""
