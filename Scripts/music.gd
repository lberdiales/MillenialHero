extends Node

onready var music_stream_1 = get_node("music_1")
onready var music_stream_2 = get_node("music_2")
onready var music_stream_3 = get_node("music_3")

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
	if (current_music_stream == music_stream_1):
		music_stream_1.set_volume(0)
		music_stream_2.set_volume(1)
		current_music_stream = music_stream_2
	elif (current_music_stream == music_stream_2):
		music_stream_2.set_volume(0)
		music_stream_3.set_volume(1)
		current_music_stream = music_stream_3
	elif (current_music_stream == music_stream_3):
		music_stream_3.set_volume(0)
		music_stream_1.set_volume(1)
		current_music_stream = music_stream_1
