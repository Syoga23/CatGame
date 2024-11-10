extends Node2D

@onready var Sprite = get_node("ScanBox/AnimatedSprite2D/Sprite2D")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var viewport_size = get_viewport().size
	self.scale = Vector2(viewport_size.x / Sprite.texture.get_size().x, viewport_size.y / Sprite.texture.get_size().y)
	self.position = Vector2(viewport_size.x/2-100, viewport_size.y/2)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
