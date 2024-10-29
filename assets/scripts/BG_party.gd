extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var viewport_size = DisplayServer.screen_get_size()
	self.position = Vector2(0, 0)
	self.scale = Vector2(0.71, 0.71)
