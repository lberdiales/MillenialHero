extends Node

onready var music_stream_1 = get_node("light")
onready var music_stream_2 = get_node("medium")
onready var music_stream_3 = get_node("heavy")
onready var animation_fadeout = get_node("animation_fadeout")
onready var animation_fadein = get_node("animation_fadein")
onready var sfx = get_node("sfx")

var current_music_stream

func _ready():
	music_stream_1.set_volume(1)
	music_stream_2.set_volume(0)
	music_stream_3.set_volume(0)
	
	music_stream_1.play()
	music_stream_2.play()
	music_stream_3.play()
	
	current_music_stream = music_stream_1
	
	set_process(true)

func _on_Button_button_up():
	var desperate = randi()%100 + randf()
	switch_music_stream(desperate / 100.0)

func switch_music_stream(desperate):
	var next_music_stream = music_stream(desperate)
	
	if (next_music_stream != current_music_stream):
		animation_fadeout.interpolate_property(current_music_stream, "stream/volume_db", 0, -80, 4, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
		animation_fadein.interpolate_property(next_music_stream, "stream/volume_db", -80, 0, 2, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
		
		animation_fadeout.start()
		animation_fadein.start()
		
		current_music_stream = next_music_stream
		
		if (next_music_stream == music_stream_1):
			sfx.play("millenial_hero_sfx_relax")
		elif (next_music_stream == music_stream_2):
			sfx.play("millenial_hero_sfx_angry_2_short")
		elif (next_music_stream == music_stream_3):
			sfx.play("millenial_hero_sfx_angry_1")

func music_stream(desperate):
	if (desperate >= 0.0 and desperate <= 1.0/3.0):
		return music_stream_1
	elif (desperate > 1.0/3.0 and desperate <= 2.0/3.0):
		return music_stream_2
	elif (desperate > 2.0/3.0 and desperate <= 3.0/3.0):
		return music_stream_3
	else:
		return current_music_stream