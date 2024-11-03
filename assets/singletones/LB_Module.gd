#LeaderBoard Module 1.0.0 >-<
extends Node

var game_API_key = "dev_8763ea40456b462b99780235a1edca5c"
var development_mode = true
var leaderboard_key = "7823HECU"

var session_token = ""
var score = 0

var active_score = false
var offline_mode = false

var output_data = []

# HTTP Request node can only handle one call per node
var auth_http = HTTPRequest.new()
var leaderboard_http = HTTPRequest.new()
var submit_score_http = HTTPRequest.new()

var set_name_http = HTTPRequest.new()
var get_name_http = HTTPRequest.new()
var lb_request = 2

func _ready():
	#null_file("user://LootLocker.data")
	_authentication_request()

func null_file(file_path: String):
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file != null:
		file.close()
	else:
		print("Error opening file: ", file)

func _authentication_request():
	# Check if a player session exists
	var player_session_exists = false
	var player_identifier : String
	var file = FileAccess.open("user://LootLocker.data", FileAccess.READ)
	if file != null:
		player_identifier = file.get_as_text()
		print("player ID="+player_identifier)
		file.close()
 
	if file != null and player_identifier.length() > 1:
		print("player session exists, id=" + player_identifier)
		player_session_exists = true
	
	if file != null and player_identifier.length() > 1:
		player_session_exists = true

	## Convert data to json string:
	var data = { "game_key": game_API_key, "game_version": "0.0.0.1", "development_mode": development_mode }
	
	# If a player session already exists, send with the player identifier
	if(player_session_exists == true):
		data = { "game_key": game_API_key, "player_identifier":player_identifier, "game_version": "0.0.0.1", "development_mode": development_mode }
	
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	# Create a HTTPRequest node for authentication

	auth_http = HTTPRequest.new()
	add_child(auth_http)
	auth_http.request_completed.connect(_on_authentication_request_completed)
	auth_http.request("https://api.lootlocker.io/game/v2/session/guest", headers, HTTPClient.METHOD_POST, JSON.stringify(data))
	
	print(data)

func _on_authentication_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	
	var file = FileAccess.open("user://LootLocker.data", FileAccess.WRITE)
	file.store_string(json.get_data().player_identifier)
	file.close()

	session_token = json.get_data().session_token
	auth_http.queue_free()
	_get_leaderboards()
	_get_player_name()


func _get_leaderboards():
	print("Getting leaderboards")
	var url = "https://api.lootlocker.io/game/leaderboards/"+leaderboard_key+"/list?count=2000"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	
	# Create a request node for getting the highscore
	leaderboard_http = HTTPRequest.new()
	add_child(leaderboard_http)
	leaderboard_http.request_completed.connect(_on_leaderboard_request_completed)
	
	# Send request
	leaderboard_http.request(url, headers, HTTPClient.METHOD_GET, "")

func _on_leaderboard_request_completed(result, response_code, headers, body):
	output_data = []
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	
	var rank = 0
	var nickname = ""
	var player_score = 0
	var id = 0
	print(json.get_data())
	
	var leaderboardFormatted = ""

	if json.get_data().size() > 0:
		for n in json.get_data().items.size():
			lb_request = 0
			rank = json.get_data().items[n].rank
			nickname = json.get_data().items[n].player.name
			player_score = json.get_data().items[n].score
			id = json.get_data().items[n].player.id
			output_data.append( {"id": id, "rank": rank, "name": nickname, "score": player_score} )
	leaderboard_http.queue_free()
	
	print(output_data)

func _upload_score():
	var data = { "score": str(score) }
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	submit_score_http = HTTPRequest.new()
	add_child(submit_score_http)
	submit_score_http.request_completed.connect(_on_upload_score_request_completed)
	# Send request
	submit_score_http.request("https://api.lootlocker.io/game/leaderboards/"+leaderboard_key+"/submit", headers, HTTPClient.METHOD_POST, JSON.stringify(data))
	# Print what we're sending, for debugging purposes:

func _change_player_name(player_name : String):
	print("Changing player name")
	
	var data = { "name": str(player_name) }
	var url =  "https://api.lootlocker.io/game/player/name"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	
	# Create a request node for getting the highscore
	set_name_http = HTTPRequest.new()
	add_child(set_name_http)
	set_name_http.request_completed.connect(_on_player_set_name_request_completed)
	# Send request
	set_name_http.request(url, headers, HTTPClient.METHOD_PATCH, JSON.stringify(data))
	
func _on_player_set_name_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	
	# Print data
	print(json.get_data())
	set_name_http.queue_free()

func _get_player_name():
	print("Getting player name")
	var url = "https://api.lootlocker.io/game/player/name"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	
	# Create a request node for getting the highscore
	get_name_http = HTTPRequest.new()
	add_child(get_name_http)
	get_name_http.request_completed.connect(_on_player_get_name_request_completed)
	# Send request
	get_name_http.request(url, headers, HTTPClient.METHOD_GET, "")

func _on_player_get_name_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())

func _on_upload_score_request_completed(result, response_code, headers, body) :
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	
	# Print data
	print("Submit:",json.get_data())
	
	# Clear node
	submit_score_http.queue_free()
