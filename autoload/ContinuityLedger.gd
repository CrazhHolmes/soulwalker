# ContinuityLedger.gd - Persistent tracking of the Tri-Currency Framework
# Manages Notarized Merits (NM), Recall Tokens (RT), and Witness Marks (WM)
# Logs all transactions to local "PlayerLedger.txt" for institutional flavor.

extends Node

signal currency_changed(type, new_balance)

const LEDGER_FILE_PATH = "user://PlayerLedger.txt"

func _ready():
	_initialize_ledger_file()

func _initialize_ledger_file():
	var file = FileAccess.open(LEDGER_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_line("# OFFICE OF CONTINUITY: OFFICIAL TRANSACTION LOG")
		file.store_line("# SUBJECT ID: " + str(OS.get_unique_id()))
		file.store_line("# STATUS: ACTIVE AUDIT")
		file.store_line("-----------------------------------------------")
		file.close()

func earn_currency(type: String, amount: int, reason: String):
	match type.to_lower():
		"nm", "notarized_merits":
			GameState.notarized_merits += amount
			_log_transaction("EARN", "NM", amount, reason)
			currency_changed.emit("nm", GameState.notarized_merits)
		"rt", "recall_tokens":
			GameState.recall_tokens += amount
			_log_transaction("EARN", "RT", amount, reason)
			currency_changed.emit("rt", GameState.recall_tokens)
		"wm", "witness_marks":
			GameState.witness_marks += amount
			_log_transaction("EARN", "WM", amount, reason)
			currency_changed.emit("wm", GameState.witness_marks)
		"dm", "doubt_marks":
			GameState.doubt_marks += amount
			_log_transaction("EARN", "DM", amount, reason)
			currency_changed.emit("dm", GameState.doubt_marks)

func spend_currency(type: String, amount: int, purpose: String, vendor_key: String = ""):
	var can_afford = false
	var current_balance = 0
	
	match type.to_lower():
		"nm", "notarized_merits":
			if GameState.notarized_merits >= amount:
				GameState.notarized_merits -= amount
				can_afford = true
				current_balance = GameState.notarized_merits
		"rt", "recall_tokens":
			if GameState.recall_tokens >= amount:
				GameState.recall_tokens -= amount
				can_afford = true
				current_balance = GameState.recall_tokens
		"wm", "witness_marks":
			if GameState.witness_marks >= amount:
				GameState.witness_marks -= amount
				can_afford = true
				current_balance = GameState.witness_marks

	if can_afford:
		_log_transaction("SPEND", type.to_upper(), amount, purpose)
		currency_changed.emit(type.to_lower(), current_balance)
		
		# Spending increases trust with the vendor
		if vendor_key != "":
			GameState.increase_trust(vendor_key, amount / 10 if amount >= 10 else 1)
			
		return true
	
	return false

func _log_transaction(action: String, type: String, amount: int, detail: String):
	var file = FileAccess.open(LEDGER_FILE_PATH, FileAccess.READ_WRITE)
	if file:
		file.seek_end()
		var timestamp = Time.get_datetime_string_from_system()
		file.store_line("[%s] %s | %d %s | %s" % [timestamp, action, amount, type, detail])
		file.close()

func get_balance(type: String) -> int:
	match type.to_lower():
		"nm": return GameState.notarized_merits
		"rt": return GameState.recall_tokens
		"wm": return GameState.witness_marks
		"dm": return GameState.doubt_marks
	return 0
