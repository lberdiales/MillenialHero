extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func set_val(val):
	var capped_val = max(min(100,val),0)
	set_frame(round((get_sprite_frames().get_frame_count("default")-1) * capped_val/100))