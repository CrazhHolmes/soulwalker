# WorldMap.gd - Main explorable world with multiple areas
# Larger landscape (1600x1200) with distinct zones and merchant buildings

extends Node2D

# Camera boundaries for the world
const WORLD_LEFT: float = 0.0
const WORLD_TOP: float = 0.0
const WORLD_RIGHT: float = 1600.0
const WORLD_BOTTOM: float = 1200.0

# UI node references
@onready var log_text: Label = $UI/LogPanel/LogVBox/LogTextLabel
@onready var visit_count: Label = $UI/LogPanel/LogVBox/VisitCountLabel
@onready var name_label: Label = $UI/PlayerInfoPanel/InfoVBox/NameLabel
@onready var archetype_label: Label = $UI/PlayerInfoPanel/InfoVBox/ArchetypeLabel
@onready var vow_label: Label = $UI/PlayerInfoPanel/InfoVBox/VowLabel
@onready var area_label: Label = $UI/AreaPanel/AreaLabel

# Day/Night cycle
@onready var day_night: CanvasModulate = $DayNightCycle
var time_of_day: float = 0.5  # 0.0 = midnight, 0.5 = noon, 1.0 = midnight
var day_speed: float = 0.01  # How fast time passes

# Colors for day/night
const DAWN_COLOR: Color = Color(1.0, 0.85, 0.75, 1.0)
const DAY_COLOR: Color = Color(1.0, 1.0, 1.0, 1.0)
const DUSK_COLOR: Color = Color(1.0, 0.7, 0.6, 1.0)
const NIGHT_COLOR: Color = Color(0.4, 0.4, 0.6, 1.0)

func _ready() -> void:
	add_to_group("world_log")
	GameState.current_scene_type = GameState.SceneType.WORLD
	
	# Display player info
	var data: Dictionary = GameState.current_player_data
	name_label.text = data.get("name", "Wanderer")
	archetype_label.text = data.get("archetype", "Unknown")
	vow_label.text = "\"" + data.get("vow", "") + "\""
	
	# Initialize log
	update_log()
	
	# Check if returning from interior - position player at saved location
	var transition_data = SceneTransition.get_transition_data()
	var player = $Player
	
	if transition_data.get("from_interior", false):
		var spawn_pos = transition_data.get("spawn_position", Vector2(800, 500))
		if player:
			player.position = spawn_pos
	
	# Setup camera limits on player
	if player:
		var camera = player.get_node_or_null("Camera2D")
		if camera:
			camera.limit_left = int(WORLD_LEFT)
			camera.limit_top = int(WORLD_TOP)
			camera.limit_right = int(WORLD_RIGHT)
			camera.limit_bottom = int(WORLD_BOTTOM)

func _process(delta: float) -> void:
	# Update day/night cycle
	time_of_day += day_speed * delta
	if time_of_day >= 1.0:
		time_of_day = 0.0
	
	update_day_night_color()
	
	# Update current area display
	update_area_display()

func update_day_night_color() -> void:
	var color: Color
	
	if time_of_day < 0.25:  # Night to dawn
		color = NIGHT_COLOR.lerp(DAWN_COLOR, time_of_day / 0.25)
	elif time_of_day < 0.5:  # Dawn to day
		color = DAWN_COLOR.lerp(DAY_COLOR, (time_of_day - 0.25) / 0.25)
	elif time_of_day < 0.75:  # Day to dusk
		color = DAY_COLOR.lerp(DUSK_COLOR, (time_of_day - 0.5) / 0.25)
	else:  # Dusk to night
		color = DUSK_COLOR.lerp(NIGHT_COLOR, (time_of_day - 0.75) / 0.25)
	
	if day_night:
		day_night.color = color

func update_area_display() -> void:
	var player = $Player
	if not player or not area_label:
		return
	
	var pos = player.position
	var area_name = "The Sanctuary"
	
	# Determine current area based on position
	if pos.y < 400:
		if pos.x < 533:
			area_name = "Herb Garden"
		elif pos.x < 1066:
			area_name = "Central Plaza"
		else:
			area_name = "Sacred Grove"
	elif pos.y < 800:
		if pos.x < 533:
			area_name = "West Path"
		elif pos.x < 1066:
			area_name = "The Crossroads"
		else:
			area_name = "East Path"
	else:
		if pos.x < 533:
			area_name = "Forest Edge"
		elif pos.x < 1066:
			area_name = "Southern Meadow"
		else:
			area_name = "Mountain Approach"
	
	area_label.text = area_name

func update_log() -> void:
	if log_text:
		if GameState.last_log_text.is_empty():
			log_text.text = "The sanctuary awaits. Explore the realm..."
		else:
			log_text.text = GameState.last_log_text
	
	if visit_count:
		var v: Dictionary = GameState.station_visits
		visit_count.text = "Apothecary: %d | Archivist: %d | Gatekeeper: %d" % [v.apothecary, v.archivist, v.gatekeeper]
