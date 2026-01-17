# ArchivistVault.gd - Specialized logic for the Vault scene

extends "res://scenes/interiors/InteriorBase.gd"

@onready var grid_ui = $UI/DocumentGridUI
@onready var doc_ui = $UI/DocumentUI

func _ready():
	super._ready()
	grid_ui.document_selected.connect(_on_document_selected)

func open_document_grid():
	grid_ui.open_grid()

func _on_document_selected(doc_id: String):
	var trust = GameState.get_trust_level("archivist")
	doc_ui.open_document(doc_id, trust)
