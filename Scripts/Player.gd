extends KinematicBody2D

signal on_player_earned_likes(likes_count)
signal on_player_drunk_coffee()

onready var player_sprite = get_node("sprite")
onready var particle_node = get_node("likes_particle")

# Status
export var MIN_DESPERATION = 0.0
export var MAX_DESPERATION = 100.0
var desperation = MIN_DESPERATION

export var TIME_TO_PROCESS_STATUS = 2
var status_delta_acum = 0.0

export var DESPERATION_DUE_TO_NO_WIFI = 5

export var MIN_BATTERY_LIFE = 0.0
export var MAX_BATTERY_LIFE = 100.0
var battery_life = MAX_BATTERY_LIFE

export var DEFAULT_BATTERY_USE = 1

export var DESPERATION_DUE_TO_LOW_BATTERY = 10
export var DESPERATION_DUE_TO_NO_BATTERY = 25

# Movement
var player_speed = 100
var player_step_freq = 10
var player_step_size = 5
var step_counter = 0

var player_nw_texture = preload("res://Assets/player_nw.png")
var player_ne_texture = preload("res://Assets/player_ne.png")
var player_se_texture = preload("res://Assets/player_se.png")
var player_sw_texture = preload("res://Assets/player_sw.png")

# Hotspot
var hotspots = []
var current_hotspot

# Tokens
onready var sfx_node = get_node("sfx")

export var SERENITY_DUE_TO_LIKE = 1

func _ready():
	set_process(true)

func _process(delta):
	process_status(delta)
	process_input(delta)

# Status
func process_status(delta):
	status_delta_acum += delta
	
	if (status_delta_acum >= TIME_TO_PROCESS_STATUS):
		print("battery_life:", battery_life, ", desperation:", desperation)
		
		var desperation_due_to_no_battery = process_battery_desperation()
		var desperation_due_to_no_wifi = process_wifi_desperation()
		
		desperation = min(desperation + desperation_due_to_no_wifi + desperation_due_to_no_battery, MAX_DESPERATION)
		
		if (desperation >= MAX_DESPERATION):
			die()
		
		# FIXME: Arreglar
		status_delta_acum = 0

func process_battery_desperation():
	battery_life = max(battery_life - DEFAULT_BATTERY_USE, MIN_BATTERY_LIFE)
	
	if (battery_life <= MIN_BATTERY_LIFE):
		return DESPERATION_DUE_TO_NO_BATTERY
	elif (battery_life <= 25.0):
		return DESPERATION_DUE_TO_LOW_BATTERY
	else:
		return DEFAULT_BATTERY_USE

func process_wifi_desperation():
	var signal_strength = 0.0
	if (current_hotspot != null):
		signal_strength = current_hotspot.signal_strength(self)
	
	return DESPERATION_DUE_TO_NO_WIFI - ((signal_strength / 100) * DESPERATION_DUE_TO_NO_WIFI)

func die():
	# Pendiente implementar
	pass

# Movement
func process_input(delta):
	var player_texture = player_sprite.get_texture()
	var player_vel = Vector2()
	var player_step = Vector2()
	step_counter += delta * player_step_freq
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
	move(player_vel)

# Hotspot
func _on_hotspot_enter(hotspot):
	if (!hotspots.has(hotspot)):
		hotspots.push_front(hotspot)
	process_hotspots()

func _on_hotspot_exit(hotspot):
	hotspots.erase(hotspot)
	process_hotspots()

func process_hotspots():
	# Aca hay que revisar cual conviene mas y conectar a ese (usando hotspot.signal_strength())
	if (hotspots.empty()):
		current_hotspot = null
		return
	
	if (current_hotspot == null):
		current_hotspot = hotspots.front()
	
	for hotspot in hotspots:
		if (hotspot.signal_strength(self) > current_hotspot.signal_strength(self)):
			current_hotspot = hotspot

# Tokens
func _on_selfie_token_found(selfie_token):
	sfx_node.play("millenial_hero_sfx_camera_flash")
	particle_node.set_emitting(true)
	desperation = max(desperation - (SERENITY_DUE_TO_LIKE * selfie_token.likes_count), MIN_DESPERATION)
	emit_signal("on_player_earned_likes", selfie_token.likes_count)

func _on_startrucks_token_found(startrucks_token):
	sfx_node.play("millenial_hero_sfx_coffee")
	battery_life = min(battery_life + startrucks_token.battery_charge, MAX_BATTERY_LIFE)
	emit_signal("on_player_drunk_coffee")