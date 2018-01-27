extends Area2D

onready var hotspot_id = get_name()

const ENERGY_CONSUMPTION = 10
const MIN_ENERGY = ENERGY_CONSUMPTION
const MAX_ENERGY = 100

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

func connect():
	# Falta consumir energia por tiempo
	consume_energy(ENERGY_CONSUMPTION)

func consume_energy(energy):
	if (available_energy > energy):
		available_energy -= energy
	else:
		available_energy = 0
		emit_signal("on_hotspot_exit", self)
		queue_free()

func signal_strength(otherTransform):
	# Deberia devolver un % (si los centros coinciden 100%)
	return 100.0