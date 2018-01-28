extends Node

# Game
onready var game = get_node("game")
onready var player = game.get_node("player")
onready var background_music = game.get_node("background_music")

# UI
onready var emoji = get_node("UI/emoji")
onready var battery = get_node("UI/battery")
onready var wifi = get_node("UI/wifi")
onready var likes = get_node("UI/likes")

func _ready():
	randomize()
	
	set_process(true)

func _process(delta):
	update_music()
	
	update_emoji()
	update_battery()
	update_wifi()
	update_likes()

func update_music():
	var desperation = player.desperation
	background_music.switch_music_stream(desperation / 100)

func update_emoji():
	var desperation = player.desperation
	emoji.set_val(desperation)

func update_battery():
	var battery_life = (player.MAX_BATTERY_LIFE - player.battery_life)
	battery.set_val(battery_life)

func update_wifi():
	var wifi_strength = 100.0
	if (player.current_hotspot != null):
		wifi_strength = wifi_strength - player.current_hotspot.signal_strength(player)
	wifi.set_val(wifi_strength)

func update_likes():
	# FIXME: Pasar likes_acum al player, no mantenerlo en Main.gd
	var likes_acum = game.likes_acum
	likes.set_val(likes_acum)