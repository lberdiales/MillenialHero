extends Node2D

onready var player = get_node("player")

onready var level_1 = get_node("level_1")
onready var level_2 = get_node("level_2")

export var current_level_nodepath = "level_1"
var current_level

func _ready():
	randomize()
	
	current_level = get_node(current_level_nodepath)
	load_level(current_level)

func load_level(level):
	var hotspots = level.get_node("hotspots")
	var tokens = level.get_node("tokens")
	
	for hotspot in hotspots.get_children():
		hotspot.connect("on_hotspot_enter", player, "_on_hotspot_enter")
		hotspot.connect("on_hotspot_exit", player, "_on_hotspot_exit")
	
	for token in tokens.get_children():
		token.connect("on_selfie_token_found", player, "_on_selfie_token_found")
		token.connect("on_startrucks_token_found", player, "_on_startrucks_token_found")

func promote_level():
	pass
	