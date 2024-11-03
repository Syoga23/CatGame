extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_state()

func set_state():
	if LbModule.active_score:
		self.text = "Введите имя для своего рекорда:"
	else:
		self.text = "Поменяйте имя для вашего рекорда"
