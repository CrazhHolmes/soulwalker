extends CanvasLayer

@onready var nm_label = $Control/MarginContainer/VBoxContainer/NMContainer/Value
@onready var rt_label = $Control/MarginContainer/VBoxContainer/RTContainer/Value
@onready var wm_label = $Control/MarginContainer/VBoxContainer/WMContainer/Value
@onready var dm_label = $Control/MarginContainer/VBoxContainer/DMContainer/Value

func _ready():
	ContinuityLedger.currency_changed.connect(_on_currency_changed)
	refresh_display()

func refresh_display():
	nm_label.text = str(GameState.notarized_merits)
	rt_label.text = str(GameState.recall_tokens)
	wm_label.text = str(GameState.witness_marks)
	dm_label.text = str(GameState.doubt_marks)
	
	# If Doubt Marks > 0, show them in red
	if GameState.doubt_marks > 0:
		dm_label.get_parent().visible = true
	else:
		dm_label.get_parent().visible = false

func _on_currency_changed(_type, _value):
	refresh_display()
	
	# Small animation effect
	var tween = create_tween()
	tween.tween_property($Control, "modulate", Color(1.5, 1.5, 1.5), 0.1)
	tween.tween_property($Control, "modulate", Color.WHITE, 0.2)
