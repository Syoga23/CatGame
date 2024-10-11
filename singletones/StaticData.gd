extends Node

var food_data = {}

var data_file_path = "res://data/food_data.json" 

func _ready():
	food_data = load_json_file(data_file_path)

func load_json_file(filePath : String):
	if FileAccess.file_exists(filePath):
		
		var data_File = FileAccess.open(filePath, FileAccess.READ)
		var parsed_Result = JSON.parse_string(data_File.get_as_text())
		
		if parsed_Result is Dictionary:
			return parsed_Result
		else:
			print("Error with JSON reading")
	else:
		print("File doesnt exist")
