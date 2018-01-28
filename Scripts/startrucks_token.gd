extends Area2D

signal on_startrucks_token_found(startrucks_token)

var battery_charge

func _ready():
	battery_charge = randi()%25 + randf()

func _on_startrucks_token_body_enter( body ):
	if (body.get_name() == "player"):
		emit_signal_and_destroy()

func emit_signal_and_destroy():
	emit_signal("on_startrucks_token_found", self)
	queue_free()