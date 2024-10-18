extends Area2D

func _physics_process(delta: float) -> void:
	var steak = get_parent()
	if(steak.fall_speed != 0):
		
		position.y += steak.fall_speed * delta
		var viewport_rect = get_viewport().get_visible_rect()
		if position.y > viewport_rect.position.y + viewport_rect.size.y:
			queue_free()
