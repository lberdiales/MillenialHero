extends Node2D

onready var player_node = get_node("player")
onready var player_sprite = get_node("player/sprite")

var player_speed = 100
var player_step_freq = 10
var player_step_size = 5
var step_counter = 0

var player_nw_texture = preload("res://Assets/player_nw.png")
var player_ne_texture = preload("res://Assets/player_ne.png")
var player_se_texture = preload("res://Assets/player_se.png")
var player_sw_texture = preload("res://Assets/player_sw.png")

func _ready():
	set_process(true)
	pass

func _process(delta):
	var player_texture = player_sprite.get_texture()
	var player_vel = Vector2()
	var player_step = Vector2()
	step_counter += delta * player_step_freq
	print(step_counter)
	var new_step = -abs(player_step_size * cos(step_counter))
	
	if (Input.is_action_pressed("left")):
		player_vel.x = -delta * player_speed * cos(deg2rad(30))
		player_vel.y = -delta * player_speed * sin(deg2rad(30))
		player_step.y = new_step
		player_texture = player_nw_texture
	
	if (Input.is_action_pressed("up")):
		player_vel.x = delta * player_speed * cos(deg2rad(30))
		player_vel.y = -delta * player_speed * sin(deg2rad(30))
		player_step.y = new_step
		player_texture = player_ne_texture
	
	if (Input.is_action_pressed("right")):
		player_vel.x = delta * player_speed * cos(deg2rad(30))
		player_vel.y = delta * player_speed * sin(deg2rad(30))
		player_step.y = new_step
		player_texture = player_se_texture
	
	if (Input.is_action_pressed("down")):
		player_vel.x = -delta * player_speed * cos(deg2rad(30))
		player_vel.y = delta * player_speed * sin(deg2rad(30))
		player_step.y = new_step
		player_texture = player_sw_texture
	
	player_sprite.set_pos(player_step)
	
	# Cambio el sprite
	player_sprite.set_texture(player_texture)
	
	# Aplico movimiento
	player_node.move(player_vel)