extends Node

var config = ConfigFile.new()

const SETTINGS_FILE_PATH = "user://settings.ini"

func _ready():
	if( !FileAccess.file_exists(SETTINGS_FILE_PATH) ):
		config.set_value("Audio", "Master", 1.0)
		config.set_value("Audio", "Music", 1.0)
		config.set_value("Audio", "SFX", 1.0)
		
		config.save(SETTINGS_FILE_PATH)
	else:
		config.load(SETTINGS_FILE_PATH)

func save_audio_settings(key: String, value: float):
	config.set_value("Audio", key, value)
	config.save(SETTINGS_FILE_PATH)

func load_audio_settings():
	var audio_settings = {}
	for key in config.get_section_keys("Audio"):
		audio_settings[key] = config.get_value("Audio", key)
	return audio_settings
