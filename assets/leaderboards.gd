extends Control

var row = preload("res://assets/scenes/RowForScoreBoard.tscn")
@onready var table = get_node("VBoxContainer/ColorRect/MarginContainer/ScrollContainer/Table")
var sn = 0

var data = []

func _ready() -> void:
	row_data(data)
	print("HELLLO")

func row_data(data : Array):
	sn = 0
	
	for i in range(LbModule.output_data.size()):
		print("SDSDSD")
		sn += 1
		var instance = row.instantiate()
		instance.name = str(sn)
		table.add_child(instance)
		get_node("VBoxContainer/ColorRect/MarginContainer/ScrollContainer/Table/" + instance.name + "/Position").text = str(LbModule.output_data[i].id)
		get_node("VBoxContainer/ColorRect/MarginContainer/ScrollContainer/Table/" + instance.name + "/Name").text = LbModule.output_data[i].name
		get_node("VBoxContainer/ColorRect/MarginContainer/ScrollContainer/Table/" + instance.name + "/Score").text = str(LbModule.output_data[i].score)
	for i in range(LbModule.output_data.size()):
		print("SDSDSD")
		sn += 1
		var instance = row.instantiate()
		instance.name = str(sn)
		table.add_child(instance)
		get_node("VBoxContainer/ColorRect/MarginContainer/ScrollContainer/Table/" + instance.name + "/Position").text = str(LbModule.output_data[i].id)
		get_node("VBoxContainer/ColorRect/MarginContainer/ScrollContainer/Table/" + instance.name + "/Name").text = LbModule.output_data[i].name
		get_node("VBoxContainer/ColorRect/MarginContainer/ScrollContainer/Table/" + instance.name + "/Score").text = str(LbModule.output_data[i].score)


func _on_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/scenes/main_menu.tscn")

func _on_refresh_pressed() -> void:
	#realize update data and putting score after death and decide if score is rewrittable
	get_tree().reload_current_scene()
