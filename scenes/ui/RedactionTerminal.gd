# RedactionTerminal.gd - Controls the memory-editing terminal interface
extends Control

signal task_completed

enum State { BOOTING, DASHBOARD, SELECTING_STAT, SELECTING_BIO, REDACTING, COMPLETE }

@onready var log_label = $DisplayArea/Content/MainDisplay/LogText
@onready var title_label = $DisplayArea/Content/MainDisplay/Title
@onready var rt_label = $DisplayArea/Content/Header/RecallTokens
@onready var input_prompt = $DisplayArea/Content/Footer/InputPrompt

@onready var hum_player = $TerminalHum
@onready var key_player = $KeyPress
@onready var static_player = $RedactionStatic

var current_state = State.BOOTING
var bio_entries = [] # To be populated by .tres files
var selected_index: int = 0
var max_selections: int = 0

func _ready():
	_load_resources()
	_start_boot_sequence()
	rt_label.text = "RT: " + str(GameState.recall_tokens)
	set_process_input(true)

func _load_resources():
	var paths = ["res://data/memories/bio_childhood_friend.tres", "res://data/memories/bio_home.tres"]
	for path in paths:
		if ResourceLoader.exists(path):
			bio_entries.append(load(path))

func _input(event):
	if event.is_action_pressed("ui_up"):
		selected_index = max(0, selected_index - 1)
		_update_selection_visuals()
		_play_click()
	elif event.is_action_pressed("ui_down"):
		selected_index = min(max_selections - 1, selected_index + 1)
		_update_selection_visuals()
		_play_click()
	elif event.is_action_pressed("interact") or event.is_action_pressed("ui_accept"):
		_handle_selection()
		_play_click()
	
	# Keep legacy number keys for PC users
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_1 and current_state == State.DASHBOARD:
			_show_bio_selection()
		elif event.keycode == KEY_0:
			if current_state == State.DASHBOARD: _close_terminal()
			else: _show_dashboard()

func _handle_selection():
	match current_state:
		State.BOOTING:
			pass
		State.DASHBOARD:
			if selected_index == 0:
				_show_bio_selection()
			elif selected_index == 2:
				_close_terminal()
		State.SELECTING_BIO:
			if selected_index < bio_entries.size():
				_start_redaction(selected_index)
			else:
				_show_dashboard()
		State.COMPLETE:
			_close_terminal()

func _play_click():
	if key_player and key_player.stream:
		key_player.pitch_scale = randf_range(0.9, 1.1)
		key_player.play()

func _start_boot_sequence():
	current_state = State.BOOTING
	log_label.text = ""
	var lines = [
		"> INITIALIZING MK-IV INTERFACE...",
		"> LOADING BIOGRAPHICAL DATABASE...",
		"> VERIFYING BOARD OF ETHICS CLEARANCE...",
		"> SUBJECT IDENTIFIED: " + GameState.current_player_data.get("name", "SUBJECT_UNSPECIFIED"),
		"> ACCESS GRANTED."
	]
	
	for line in lines:
		log_label.text += line + "\n"
		await get_tree().create_timer(0.4).timeout
	
	_show_dashboard()

func _show_dashboard():
	current_state = State.DASHBOARD
	title_label.text = "CALIBRATION DASHBOARD"
	selected_index = 0
	max_selections = 3
	_update_selection_visuals()
	input_prompt.text = "NAVIGATE [UP/DOWN] - SELECT [ENTER/X]"

func _show_bio_selection():
	current_state = State.SELECTING_BIO
	title_label.text = "SELECT ENTRY FOR ARCHIVAL"
	selected_index = 0
	max_selections = bio_entries.size() + 1
	_update_selection_visuals()
	input_prompt.text = "SELECT ENTRY - [0] TO RETURN"

func _update_selection_visuals():
	match current_state:
		State.DASHBOARD:
			var lines = [
				"[1] INITIATE BIOGRAPHICAL REDACTION",
				"[2] REVIEW CALIBRATION STATS (RESTRICTED)",
				"[0] TERMINATE SESSION"
			]
			for i in range(lines.size()):
				if selected_index == i:
					lines[i] = ">>> " + lines[i] + " <<<"
			log_label.text = "\n".join(lines)
			
		State.SELECTING_BIO:
			var list = []
			if bio_entries.size() == 0:
				list.append("NO BIOGRAPHIES INDEXED.")
			else:
				for i in range(bio_entries.size()):
					var entry = bio_entries[i]
					var line = "[" + str(i+1) + "] " + entry.display_name + " (Cost: " + str(entry.rt_cost) + " RT)"
					if selected_index == i:
						line = ">>> " + line + " <<<"
					list.append(line)
			
			var back_line = "[0] RETURN"
			if selected_index == bio_entries.size():
				back_line = ">>> " + back_line + " <<<"
			list.append("\n" + back_line)
			
			log_label.text = "\n".join(list)

func _start_redaction(index):
	if index >= bio_entries.size(): return
	var entry = bio_entries[index]
	
	if GameState.recall_tokens < entry.rt_cost:
		log_label.text = "!! INSUFFICIENT RECALL TOKENS !!\nARCHIVAL ABORTED.\n\n[0] RETURN"
		return

	current_state = State.REDACTING
	GameState.recall_tokens -= entry.rt_cost
	rt_label.text = "RT: " + str(GameState.recall_tokens)
	
	title_label.text = "ARCHIVAL IN PROGRESS..."
	log_label.text = entry.pre_redaction_text + "\n\n"
	
	if static_player and static_player.stream: static_player.play()
	
	var words = entry.pre_redaction_text.split(" ")
	await get_tree().create_timer(1.0).timeout
	
	for i in range(words.size()):
		if randf() > 0.3:
			words[i] = "█".repeat(words[i].length())
		
		log_label.text = " ".join(words)
		await get_tree().create_timer(0.08).timeout
	
	if static_player: static_player.stop()
	_complete_redaction(entry)

func _complete_redaction(entry):
	current_state = State.COMPLETE
	title_label.text = "CALIBRATION COMPLETE"
	log_label.text += "\n\nMEMORIES ARCHIVED RESPONSIBLY.\nPHYSICAL COMPLIANCE INCREASED.\nYOU ARE LIGHTER NOW."
	input_prompt.text = "PRESS ANY KEY TO EXIT"
	
	if entry.key_consequence_flag != "":
		GameState.set_flag(entry.key_consequence_flag, true)
	
	GameState.player_max_health += 10
	GameState.player_current_health = GameState.player_max_health

func _close_terminal():
	visible = false
	emit_signal("task_completed")
