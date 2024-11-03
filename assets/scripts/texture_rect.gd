extends TextureRect

var rotation_speed: float = 180.0

var rotate = false 

func _ready() -> void:
	self.pivot_offset = Vector2(get_rect().size.x/2, get_rect().size.y/2)

func _process(delta: float) -> void:
	if rotate:
		rotation_degrees += rotation_speed * delta

func set_rotate(value : bool):
	rotate = value
