extends TextureProgressBar

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_player_area_2d_health_changed(points):
	self.value = points
