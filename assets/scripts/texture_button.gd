extends TextureButton

func _ready() -> void:
	self.pivot_offset = self.get_rect().size/2

func _process(delta: float) -> void:
	pass

func _on_button_up() -> void:
	self.scale = Vector2(1, 1)

func _on_button_down() -> void:
	self.scale = Vector2(0.75, 0.75)
