extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var label = get_node('likes')

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
func set_val(val):
	label.set_text(String(val) + ' likes')