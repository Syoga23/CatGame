extends CanvasLayer

var is_pause = false

@onready var GameOver = %GameOver

func _ready() -> void:
	self.hide()

func _on_pause_button_pressed() -> void:
	self.show()
	is_pause = true
	get_tree().paused = true

func _on_continue_pressed() -> void:
	self.hide()
	is_pause = false
	get_tree().paused = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):  
		if !GameOver.visible:
			if !is_pause:
				_on_pause_button_pressed() 
			else:
				_on_continue_pressed()


func _on_exit_pressed() -> void:
	self.hide()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://assets/scenes/main_menu.tscn")
