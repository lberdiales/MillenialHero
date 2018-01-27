extends Node2D

onready var player_node = get_node("player")
onready var player_sprite = get_node("player/sprite")

var player_speed = 150

var player_left_texture = preload("res://Assets/player_left.png")
var player_up_texture = preload("res://Assets/player_up.png")
var player_right_texture = preload("res://Assets/player_right.png")
var player_down_texture = preload("res://Assets/player_down.png")

func _ready():
	set_process(true)
	pass

func _process(delta):
	var player_texture = player_sprite.get_texture()
	var player_vel = Vector2(0, 0)
	
	if (Input.is_action_pressed("left")):
		player_vel.x = -delta * player_speed
		player_texture = player_left_texture
	
	if (Input.is_action_pressed("up")):
		player_vel.y = -delta * player_speed
		player_texture = player_up_texture
	
	if (Input.is_action_pressed("right")):
		player_vel.x = delta * player_speed
		player_texture = player_right_texture
	
	if (Input.is_action_pressed("down")):
		player_vel.y = delta * player_speed
		player_texture = player_down_texture
	
	# Cambio el sprite
	player_sprite.set_texture(player_texture)
	
	# Aplico movimiento
	player_node.move(player_vel)