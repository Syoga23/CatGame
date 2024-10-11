extends Control

@onready var settings : Control = %Settings

func _ready():
	settings.visible = false

func _on_exit_pressed():
	get_tree().quit()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_settings_pressed():
	settings.visible = true
