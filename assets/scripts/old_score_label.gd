extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_state()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_state():
	if LbModule.active_score:
		self.visible = true
		self.text = "Старый счет:" #+str(oldscore)
	else:
		self.visible = false
	LbModule._search_player_old_score()