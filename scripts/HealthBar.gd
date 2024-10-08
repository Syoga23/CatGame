extends TextureProgressBar

func _ready():
	pass # Replace with function body.

func on_hp_update(points): 
	self.value = points

func _on_tree_entered():
	EventBus.health_changed.connect(on_hp_update)

func _on_tree_exiting():
	EventBus.health_changed.disconnect(on_hp_update)
