extends Area2D

@export var fall_speed: float = 200.0

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta: float) -> void:
	position.y += fall_speed * delta

	var viewport_rect = get_viewport().get_visible_rect()
	if position.y > viewport_rect.position.y + viewport_rect.size.y:
		queue_free()
