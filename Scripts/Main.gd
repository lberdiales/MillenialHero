extends Node2D

onready var player = get_node("player")
onready var tokens = get_node("tokens")

func _ready():
	for token in tokens.get_children():
		token.connect("on_selfie_token_found", player, "_on_selfie_token_found")
		token.connect("on_startrucks_token_found", player, "_on_startrucks_token_found")