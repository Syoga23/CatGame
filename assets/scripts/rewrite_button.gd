extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_state()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_state():
	if LbModule.active_score:
		self.text = "Перезаписать счет"
	else:
		self.text = "Поменять имя рекорда"
	
