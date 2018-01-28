extends Node2D

onready var player = get_node("player")

onready var levels = get_node("levels").get_children()
var current_level = 0

export var LIKES_PER_LEVEL = 2
var likes_acum = 0

func _ready():
	randomize()
	
	player.connect("on_player_earned_likes", self, "_on_player_earned_likes")
	player.connect("on_player_drunk_coffee", self, "_on_player_drunk_coffee")
	
	load_level(levels.front())

func load_level(level):
	var hotspots = level.get_node("hotspots")
	var tokens = level.get_node("tokens")
	
	for hotspot in hotspots.get_children():
		hotspot.connect("on_hotspot_enter", player, "_on_hotspot_enter")
		hotspot.connect("on_hotspot_exit", player, "_on_hotspot_exit")
	
	for token in tokens.get_children():
		token.connect("on_selfie_token_found", player, "_on_selfie_token_found")
		token.connect("on_startrucks_token_found", player, "_on_startrucks_token_found")
	
	level.show()

func _on_player_earned_likes(likes_count):
	likes_acum += likes_count

func _on_player_drunk_coffee():
	var next_level_likes = next_level_likes()
	
	if (likes_acum >= next_level_likes):
		load_next_level()

func next_level():
	return current_level + 1

func next_level_likes():
	return next_level() * LIKES_PER_LEVEL

func load_next_level():
	if (levels.empty()):
		return
	var current_level_node = levels.front()
	current_level_node.queue_free()
	levels.pop_front()
	
	var next_level_node = levels.front()
	if (next_level_node != null):
		load_level(next_level_node)
		current_level = next_level()
	else:
		# FIXME: Hay que codear pantalla de fin
		print("condicion de fin")