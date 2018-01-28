extends Area2D

signal on_selfie_token_found(selfie_token)

var likes_count

func _ready():
	randomize()
	likes_count = randi()%10 + 1

func _on_selfie_token_body_enter( body ):
	if (body.get_name() == "player"):
		emit_signal_and_destroy()

func emit_signal_and_destroy():
	emit_signal("on_selfie_token_found", self)
	queue_free()