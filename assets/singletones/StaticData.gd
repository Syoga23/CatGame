extends Node

var food_data = {}
var level_data = {}
var chances_data = {}

var data_file_path = "res://assets/data/food_data.json" 
var level_file_path = "res://assets/data/level_data.json"
var chances_data_path = "res://assets/data/food_drop_chances_data.json"

func _ready():
	food_data = load_json_file(data_file_path)
	level_data = load_json_file(level_file_path)
	chances_data = load_json_file(chances_data_path)

func load_json_file(file_path : String):
	if FileAccess.file_exists(file_path):
		
		var data_file = FileAccess.open(file_path, FileAccess.READ)
		var parsed_Result = JSON.parse_string(data_file.get_as_text())
		
		if parsed_Result is Dictionary:
			return parsed_Result
		else:
			print("Error with JSON reading")
	else:
		print("Json file doesnt exist")
