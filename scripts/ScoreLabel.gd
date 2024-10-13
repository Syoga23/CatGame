extends Label

func on_score_update(score):
	self.text = "счет: " + str(score)

func _on_tree_entered():
	EventBus.score_changed.connect(on_score_update)

func _on_tree_exiting():
	EventBus.score_changed.disconnect(on_score_update)
