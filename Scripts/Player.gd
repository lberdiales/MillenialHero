extends KinematicBody2D

var hotspots = []
var current_hotspot

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_hotspot_enter( hotspot ):
	if(!hotspots.has(hotspot)):
		hotspots.push_front(hotspot)
	process_hotspots()

func _on_hotspot_exit( hotspot ):
	hotspots.erase(hotspot)
	process_hotspots()

func process_hotspots():
	# Aca hay que revisar cual conviene mas y conectar a ese (usando hotspot.signal_strength())
	if(hotspots.size()==0):
		current_hotspot = null
		return
		
	if(current_hotspot == null): current_hotspot = hotspots.front()
	for hotspot in hotspots:
		if(hotspot.signal_strength(self) >current_hotspot.signal_strength(self)):
			current_hotspot = hotspot