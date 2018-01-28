extends Area2D

signal on_selfie_token_found()

onready var sound_node = get_node("sound")

export var likes = 10

func _ready():
	pass

func _on_selfie_token_body_enter( body ):
	if (body.get_name() == "player"):
		play_sound()
		emit_signal_and_destroy()

func play_sound():
	sound_node.play("millenial_hero_sfx_camera_flash")

func emit_signal_and_destroy():
	emit_signal("on_selfie_token_found")
	queue_free()
