extends Control

var row = preload("res://assets/scenes/RowForScoreBoard.tscn")

var table_string_adress = "VBoxContainer/ColorRect/MarginContainer/ScrollContainer/Table"

@onready var table = get_node(table_string_adress)
@onready var SumbitUI = %SubmitUI
@onready var NicknameEdit = %NicknameEdit
@onready var refresh_status = %RefreshStatus

@onready var ScoreLabel = %ScoreLabel
@onready var RecordDescription = %RecordDescription
@onready var RewriteButton = %RewriteButton
@onready var DangerText = %DangerText

var sn = 0
var data = []
var is_running = false

func _ready() -> void:
	if LbModule.active_score:
		SumbitUI.visible = true
	else:
		SumbitUI.visible = false
	setup_table_data()

func setup_table_data():
	clean_table()
	sn = 0
	for i in range(LbModule.output_data.size()):
		sn += 1
		var instance = row.instantiate()
		instance.name = str(sn)
		table.add_child(instance)
		get_node(table_string_adress + "/" + instance.name + "/Position").text = str(LbModule.output_data[i].rank)
		get_node(table_string_adress + "/" + instance.name + "/Name").text = LbModule.output_data[i].name
		get_node(table_string_adress + "/" + instance.name + "/Score").text = str(LbModule.output_data[i].score)

func _on_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/scenes/main_menu.tscn")

func clean_table():
	var temp_table = get_node("VBoxContainer/ColorRect/MarginContainer/ScrollContainer/Table")
	for child in temp_table.get_children():
		temp_table.remove_child(child)

func _on_refresh_pressed() -> void:
	if is_running:
		print("Still running try again later")
		return
	is_running = true
	refresh_status.set_rotate(true)
	LbModule._get_leaderboards()
	await get_tree().create_timer(3)
	if LbModule.lb_request == 0:
		setup_table_data()
	await get_tree().create_timer(1).timeout
	refresh_status.set_rotate(false)
	is_running = false

func _on_change_name_pressed() -> void:
	SumbitUI.visible = true

func _on_rewrite_button_pressed() -> void:
	if LbModule.active_score:
		LbModule._change_player_name(NicknameEdit.text)
		LbModule._upload_score()
		LbModule.active_score = false
		update_UI_status()
		SumbitUI.visible = false
	if !LbModule.active_score:
		LbModule._change_player_name(NicknameEdit.text)
		LbModule._get_player_name()
	SumbitUI.visible = false

func _on_cancel_button_pressed() -> void:
	SumbitUI.visible = false

func update_UI_status():
	ScoreLabel.set_state()
	DangerText.set_state()
	RecordDescription.set_state()
	RewriteButton.set_state()
