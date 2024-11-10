extends Control

@onready var settings : Control = %Settings

func _ready():
	settings.visible = false
	#if Viewpo
	

func _on_exit_pressed():
	get_tree().quit()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://assets/scenes/game.tscn")

func _on_settings_pressed():
	settings.visible = true
	
func _on_about_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/scenes/party_room.tscn")

func _on_leader_board_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/scenes/leaderboards.tscn")
