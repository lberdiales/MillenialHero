extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var label = get_child(0)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func set_val(val):
	label.set_text(String(val))