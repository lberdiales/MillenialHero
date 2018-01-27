extends Node2D

onready var player_node = get_node("player")
onready var player_sprite = get_node("player/sprite")

var player_speed = 150

var player_nw_texture = preload("res://Assets/player_nw.png")
var player_ne_texture = preload("res://Assets/player_ne.png")
var player_se_texture = preload("res://Assets/player_se.png")
var player_sw_texture = preload("res://Assets/player_sw.png")

func _ready():
	set_process(true)
	pass

func _process(delta):
	var player_texture = player_sprite.get_texture()
	var player_vel = Vector2(0, 0)
	
	if (Input.is_action_pressed("left")):
		player_vel.x = -delta * player_speed
		player_texture = player_nw_texture
	
	if (Input.is_action_pressed("up")):
		player_vel.y = -delta * player_speed
		player_texture = player_ne_texture
	
	if (Input.is_action_pressed("right")):
		player_vel.x = delta * player_speed
		player_texture = player_se_texture
	
	if (Input.is_action_pressed("down")):
		player_vel.y = delta * player_speed
		player_texture = player_sw_texture
	
	# Cambio el sprite
	player_sprite.set_texture(player_texture)
	
	# Aplico movimiento
	player_node.move(player_vel)