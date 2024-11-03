extends Sprite2D

func _ready() -> void:
	var viewport_size = get_viewport_rect().size
	self.position = Vector2(0, 0)
	self.scale = Vector2(viewport_size.x / texture.get_size().x, viewport_size.y / texture.get_size().y)
