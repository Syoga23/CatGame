extends Control

@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

@onready var SFX_Slider : HSlider = %SFXSlider
@onready var Music_Slider : HSlider = %MusicSlider
@onready var Master_Slider : HSlider = %MasterSlider
@onready var Mute_Checkbox : CheckBox = %CheckBox
@onready var Mute_Label : Label = %MuteLabel

var limit_value = 0

var audio_settings = {}

func _ready():
	audio_settings = ConfigFileHandler.load_audio_settings()
	limit_value = Master_Slider.value
	Master_Slider.value = min(audio_settings.Master, 1.0) * 100
	Music_Slider.value = min(audio_settings.Music, 1.0) * 100
	SFX_Slider.value = min(audio_settings.SFX, 1.0) * 100
	Mute_Checkbox.button_pressed = !audio_settings.Mute
	label_checkbox(!audio_settings.Mute)
	AudioServer.set_bus_mute(MASTER_BUS_ID, audio_settings.Mute) 

func _on_back_button_pressed():
	self.visible = false

func _on_sfx_slider_value_changed(value):
	if value >= limit_value:
		SFX_Slider.value = limit_value
	else:
		AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value)) 
		AudioServer.set_bus_mute(SFX_BUS_ID, value < .05)

func _on_music_slider_value_changed(value):
	if value >= limit_value:
		Music_Slider.value = limit_value
	else:
		AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value)) 
		AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)
		

func _on_master_slider_value_changed(value):
	Music_Slider.value = min(Music_Slider.value, value)
	SFX_Slider.value = min(SFX_Slider.value, value)
	limit_value = value

func _on_music_slider_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_settings("Music", Music_Slider.value / 100)

func _on_sfx_slider_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_settings("SFX", SFX_Slider.value / 100)

func _on_master_slider_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_settings("Master", Master_Slider.value / 100)

func _on_check_box_toggled(toggled_on: bool) -> void:
	label_checkbox(toggled_on)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), !toggled_on)
	ConfigFileHandler.save_audio_settings_bool("Mute", !toggled_on)

func label_checkbox(value : bool):
	if value:
		Mute_Label.text = "Отключить звук"
	else:
		Mute_Label.text = "Включить звук"
