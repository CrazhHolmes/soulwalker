# DocumentGridUI.gd - Displays a list of accessible documents in the vault

extends Control

signal document_selected(doc_id)

@onready var grid = $CenterContainer/MainPanel/VBox/ScrollContainer/GridContainer

func _ready():
	visible = false

func populate_grid(trust_level: int):
	# Clear existing
	for child in grid.get_children():
		child.queue_free()
	
	var docs = DocumentSearch.get_visible_documents(trust_level)
	for doc_id in docs:
		var data = DocumentSearch.get_document(doc_id)
		var btn = Button.new()
		btn.text = data["title"]
		btn.custom_minimum_size = Vector2(150, 40)
		btn.pressed.connect(_on_doc_pressed.bind(doc_id))
		grid.add_child(btn)

func _on_doc_pressed(doc_id: String):
	document_selected.emit(doc_id)
	visible = false

func _on_close_pressed():
	visible = false

func open_grid():
	var trust = GameState.get_trust_level("archivist")
	populate_grid(trust)
	visible = true
