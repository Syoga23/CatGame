extends Control

@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

@onready var SFX_Slider : HSlider = %SFXSlider
@onready var Music_Slider : HSlider = %MusicSlider
@onready var Master_Slider : HSlider = %MasterSlider

func _ready():
	var audio_settings = ConfigFileHandler.load_audio_settings()
	Music_Slider.value = min(audio_settings.Music, 1.0) * 100
	SFX_Slider.value = min(audio_settings.SFX, 1.0) * 100
	Master_Slider.value = min(audio_settings.Master, 1.0) * 100

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_save_button_pressed():
	pass # Replace with function body.

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value)) 
	AudioServer.set_bus_mute(SFX_BUS_ID, value < .05)

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value)) 
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)

#CHANGE THIS IN FUTURE
func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value)) 
	AudioServer.set_bus_mute(MASTER_BUS_ID, value < .05)

func _on_music_slider_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_settings("Music", Music_Slider.value / 100)

func _on_sfx_slider_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_settings("SFX", SFX_Slider.value / 100)

func _on_master_slider_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_settings("Master", Master_Slider.value / 100)
