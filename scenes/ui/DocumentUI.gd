# DocumentUI.gd - The interactive document viewer
# Handles text typing, redaction scanning, and fragment collection

extends Control

signal document_closed

var current_doc_id: String = ""
var redaction_level: float = 0.9
var reveal_target: float = 0.0
var is_scanning: bool = false

@onready var content_label = $MainPanel/MarginContainer/VBox/ContentLabel
@onready var title_label = $MainPanel/MarginContainer/VBox/TitleLabel
@onready var category_label = $MainPanel/MarginContainer/VBox/Header/CategoryLabel
@onready var type_timer = $TypeTimer
@onready var scan_timer = $ScanTimer

func _ready():
	# Initialize shader
	content_label.material.set_shader_parameter("redaction_level", redaction_level)
	visible = false

func open_document(doc_id: String, trust_level: int):
	var data = get_tree().root.get_node("DocumentSearch").get_document(doc_id)
	if data.is_empty(): return
	
	current_doc_id = doc_id
	title_label.text = data["title"]
	category_label.text = data["category"]
	content_label.text = data["content"]
	
	# Initial redaction based on data
	redaction_level = data["redaction_level"]
	reveal_target = max(0.0, redaction_level - (trust_level * 0.2))
	
	content_label.material.set_shader_parameter("redaction_level", redaction_level)
	
	visible = true
	# Start "typing" effect if needed
	# For now, just show

func _process(delta):
	if is_scanning and redaction_level > reveal_target:
		redaction_level -= delta * 0.1
		content_label.material.set_shader_parameter("redaction_level", redaction_level)
		if redaction_level <= reveal_target:
			is_scanning = false
			# Signal success/fragment collection

func _on_scan_button_pressed():
	is_scanning = true
	# Play sound?

func _on_close_button_pressed():
	visible = false
	document_closed.emit()
