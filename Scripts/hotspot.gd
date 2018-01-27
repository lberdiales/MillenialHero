extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_hotspot_body_enter( body ):
	print ("_on_hotspot_body_enter: ", body.get_name())


func _on_hotspot_body_exit( body ):
	print ("_on_hotspot_body_exit: ", body.get_name())
