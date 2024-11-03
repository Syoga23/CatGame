extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_state()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_state():
	if LbModule.active_score:
		self.visible = true
		self.text = "ваш счет: " + str(LbModule.score)
	else:
		self.visible = false
