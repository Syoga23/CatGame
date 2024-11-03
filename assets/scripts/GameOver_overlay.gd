extends CanvasLayer

@onready var Game_Over : AudioStreamPlayer = $GameOver
@onready var Score : Label = %ScoreLabel
@onready var Score_Death : Label = %ScoreLabel_Death
# Called when the node enters the scene tree for the first time.

func _ready():
	self.hide()

func _on_quit_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://assets/scenes/main_menu.tscn") 

func _on_play_again_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_leaders_button_pressed():
	pass # Replace with function body.

func on_game_over():
	Game_Over.play()
	Score.visible = false
	Score_Death.text = Score.text 
	get_tree().paused = true
	self.show()

func _on_records_button_pressed() -> void:
	get_tree().paused = false
	LbModule.active_score = true
	get_tree().change_scene_to_file("res://assets/scenes/leaderboards.tscn")

func _on_tree_entered():
	EventBus.game_over.connect(on_game_over)

func _on_tree_exiting():
	EventBus.game_over.disconnect(on_game_over)
