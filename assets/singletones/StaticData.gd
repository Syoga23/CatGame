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

"""
func save_json_file(path : int, data : Dictionary):
	var temp_path = null
	if(path == 0):
		temp_path = data_file_path
	elif(path == 1):
		temp_path = level_file_path
	else:
		print("error on save_json_file path: out of range")
		
	if FileAccess.file_exists(temp_path):
		if data is Dictionary:
			var data_file = FileAccess.open(temp_path, FileAccess.READ)
			data_file.store_string(JSON.stringify(data))
			data_file.close()
			data_file = null
			load_json_file(temp_path)
		else:
			print("Error with JSON saving")
	else:
		print("Json file doesnt exist")
"""

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
