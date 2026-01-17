# ContinuityEnforcer.gd - Institutional Auditor NPC / Enemy
extends EnemyBase

var audit_timer: float = 0.0
var audit_interval: float = 10.0 # Time between audit checks
var is_auditing: bool = false

func _physics_process(delta):
	super._physics_process(delta)
	
	if is_active and not is_auditing:
		audit_timer += delta
		if audit_timer >= audit_interval:
			_on_audit()
			audit_timer = 0.0

func _on_audit():
	is_auditing = true
	print("Continuity Enforcer: Initiating Audit...")
	
	var rt = GameState.recall_tokens
	var dm = GameState.doubt_marks
	
	var msg = ""
	if rt > 5:
		msg = "OFFICIAL RECORD: Subject is hoarding memory-tier assets [RT: " + str(rt) + "]. Redaction is advised."
	elif dm > 0:
		msg = "ALERT: Subject carries Doubt Marks. Perception drift is unacceptable."
	else:
		msg = "AUDIT COMPLETE: Subject remains within compliance parameters."
	
	# Communicate to World Log
	GameState.last_log_text = msg
	GameState.last_theme = "ENFORCEMENT"
	
	var root = get_tree().current_scene
	if root.has_method("update_log"):
		root.update_log()
	
	# If suspicious, trigger aggression/debuff
	if rt > 5 or dm > 0:
		speed *= 1.5 # Chase faster
		modulate = Color(1.5, 0.5, 0.5) # Glow redder
		_apply_scrutiny_debuff()
	
	await get_tree().create_timer(3.0).timeout
	is_auditing = false

func _apply_scrutiny_debuff():
	# Scrutiny: Slower movement for player
	if player and player.has_method("apply_debuff"):
		player.apply_debuff("SCRUTINY", 5.0)
