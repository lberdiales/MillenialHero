extends Area2D

signal on_selfie_token_found(selfie_token)

# FIXME: Definir cantidad de likes/reputacion
export var likes = 10

func _ready():
	pass

func _on_selfie_token_body_enter( body ):
	if (body.get_name() == "player"):
		emit_signal_and_destroy()

func emit_signal_and_destroy():
	emit_signal("on_selfie_token_found", self)
	queue_free()