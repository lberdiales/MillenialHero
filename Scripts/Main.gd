extends Node2D

var player_speed = 150

var player_left_texture = preload("res://assets/PlayerLeft.png")
var player_up_texture = preload("res://assets/PlayerUp.png")
var player_right_texture = preload("res://assets/PlayerRight.png")
var player_down_texture = preload("res://assets/PlayerDown.png")

func _ready():
	set_process(true)
	pass

func _process(delta):
	var player_texture = get_node("player/player_texture").get_texture()
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
	get_node("player/player_texture").set_texture(player_texture)
	
	# Aplico movimiento
	get_node("player").move(player_vel)