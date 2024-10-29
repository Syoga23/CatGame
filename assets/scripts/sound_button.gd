extends TextureButton

@onready var Pause_Overlay : CanvasLayer = %Pause

var is_toggled
var audio_settings = {}

func _ready() -> void:
	#mute = false
	audio_settings = ConfigFileHandler.load_audio_settings()
	is_toggled = !audio_settings.Mute
	check_toggle()
	self.pivot_offset = self.get_rect().size/2

func _on_button_up() -> void:
	self.scale = Vector2(1, 1)

func _on_button_down() -> void:
	self.scale = Vector2(0.75, 0.75)

func _on_pressed() -> void:
	is_toggled = !is_toggled
	check_toggle()
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), !is_toggled)
	ConfigFileHandler.save_audio_settings_bool("Mute", !is_toggled)

func check_toggle() -> void:
	if is_toggled:
		self.texture_normal = preload("res://assets/textures/UI/buttons/sound_on.png")
	else:
		self.texture_normal = preload("res://assets/textures/UI/buttons/sound_off.png")
	
