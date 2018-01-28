extends Area2D

onready var hotspot_id = get_name()
onready var collider = get_child(0)
onready var top = get_node('top')
onready var side = get_node('side')
onready var ratio = side.get_pos().x/-top.get_pos().y

var draw_queue = []

export var ENERGY_CONSUMPTION = 10
export var MAX_ENERGY = 100
var MIN_ENERGY = ENERGY_CONSUMPTION

var available_energy

signal on_hotspot_enter(hotspot)
signal on_hotspot_exit(hotspot)

func _ready():
	randomize()
	available_energy = randi()%MAX_ENERGY+MIN_ENERGY
	
func _on_hotspot_body_enter( body ):
	if (body.get_name() == "player"):
		emit_signal("on_hotspot_enter", self)

func _on_hotspot_body_exit( body ):
	if (body.get_name() == "player"):
		emit_signal("on_hotspot_exit", self)

func signal_strength(otherTransform):
	var screen_distance = otherTransform.get_global_pos()-get_pos()
	var distance = Vector2().distance_to(Vector2( screen_distance.x, screen_distance.y * ratio))
	return 100.0 - ((distance/side.get_pos().x) * 100.0)