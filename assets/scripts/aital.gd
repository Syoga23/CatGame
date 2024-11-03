extends RichTextLabel

var key_sequence: Array = ["G", "A", "Y"]
var current_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text = "[center]sherilbi(Айтал)[/center]"
	self.modulate = Color(1,1,0)
	
func _process(delta: float) -> void:
	pass


func _input(event):
	if event is InputEventKey and event.pressed:
		var keycode = DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode)
		var key = OS.get_keycode_string(keycode)
		if key == key_sequence[current_index]:
			current_index += 1
			if current_index == key_sequence.size():
				# Сработало событие
				self.modulate = Color(1,1,1)
				self.text = "[center][wave amp=120,freq=5][rainbow freq=0.4,sat=0.8,val=0.9]sherilbi(Айтал)[/rainbow][/wave][/center]"
				current_index = 0  # Сброс индекса
		else:
			current_index = 0  # Сброс индекса, если последовательность прервана
