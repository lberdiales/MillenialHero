extends KinematicBody2D

var hotspots = {}

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_hotspot_enter( hotspot ):
	hotspots[hotspot.hotspot_id] = hotspot
	process_hotspots()


func _on_hotspot_exit( hotspot ):
	hotspots.erase(hotspot.hotspot_id)
	process_hotspots()

func process_hotspots():
	# Aca hay que revisar cual conviene mas y conectar a ese
	if (hotspots.size() > 0):
		hotspots.values().front().connect()