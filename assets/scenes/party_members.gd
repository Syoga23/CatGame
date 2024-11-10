extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scale_x = get_viewport().size.x / EventBus.old_vp_size.x
	var scale_y = get_viewport().size.y / EventBus.old_vp_size.y
	
	for child in self.get_children():
		var child_x = child.global_position.x / EventBus.old_vp_size.x 
		var child_y = child.global_position.y / EventBus.old_vp_size.y 
		
		child.global_position = Vector2(get_viewport().size.x * child_x, get_viewport().size.y * child_y)
		child.scale = Vector2(child.scale.x * scale_x, child.scale.y * scale_y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
