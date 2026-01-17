# DocumentSearch.gd - Handles the Archivist Vault's document interaction system
# Tracks found documents and manages the evidence board state

extends Node

# Document data structure
class_name ArchiveDocument
var id: String
var title: String
var category: String # Official, Personal, Incident, etc.
var content: String
var redaction_level: float = 0.8
var trust_required: int = 1
var fragment_id: String
var is_trap: bool = false

# Database of available documents
var document_db: Dictionary = {
	"doc_001": {
		"title": "Personnel File: SUBJECT ZERO",
		"category": "Official Records",
		"content": "Subject admitted on [REDACTED]. Vitals stable. Previous memory wipes: [REDACTED]. Recommendation: Continued isolation.",
		"redaction_level": 0.9,
		"trust_required": 1,
		"fragment_id": "frag_subject_id"
	},
	"doc_002": {
		"title": "Incident Report #412",
		"category": "Incident Reports",
		"content": "The breach occurred at [REDACTED] hours. The Soulwalker demonstrated [REDACTED] capabilities. Total casualties: [REDACTED]. File closed by order of The Archivist.",
		"redaction_level": 0.7,
		"trust_required": 2,
		"fragment_id": "frag_breach_memory"
	},
	"doc_003": {
		"title": "Unsent Letter",
		"category": "Personal Files",
		"content": "If you are reading this, I have already forgotten you. The Archivist promised me that the [REDACTED] would save us both. I'm sorry.",
		"redaction_level": 0.5,
		"trust_required": 3,
		"fragment_id": "frag_forgotten_loved_one"
	}
}

# State tracking
var discovered_doc_ids: Array = []
var collected_fragments: Array = []

func _ready():
	# Initially, some basic docs discovered
	discovered_doc_ids = ["doc_001"]

func get_document(id: String) -> Dictionary:
	return document_db.get(id, {})

func collect_fragment(fragment_id: String):
	if fragment_id not in collected_fragments:
		collected_fragments.append(fragment_id)
		# Update GameState or handle UI here

func get_visible_documents(trust_level: int) -> Array:
	var visible_docs = []
	for id in document_db:
		if document_db[id]["trust_required"] <= trust_level:
			visible_docs.append(id)
	return visible_docs
