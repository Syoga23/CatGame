extends Node2D

var Score = 0
var level = 0

var food_order = []

var levels = StaticData.level_data["levels"]
var foods = StaticData.food_data["foods"]

var found_data = null

func _ready():
	change_level(0)

func _process(delta):
	
	if Score >= 150:
		#medium
		change_level(1)
	if Score >= 500:
		#hard
		change_level(2)
	if Score >= 1500:
		#infinite
		change_level(3)

func change_level(level_no : int):
	food_order = []
	
	for key in levels:
		if (key["level"] == level_no && key["locked"] ==  true):
			return
		if key["level"] == level_no:
			found_data = key
			break
	level = found_data["level"]
	levels[level]["locked"] = true
	
	var food_arr_size = StaticData.food_data["foods"].size()
	for x in range(food_arr_size):
		foods[x]["fall_speed"] += levels[level]["fall_speed_modifier"]
	EventBus.food_gen_timer.emit(levels[level]["timer_delay"])
	for x in levels[level]["food_types"].size():
		food_order.append(levels[level]["food_types"][x])
	EventBus.food_gen_order.emit(level)

func set_score(score_points):
	Score = score_points

func _on_tree_entered():
	EventBus.score_changed.connect(set_score)

func _on_tree_exiting():
	EventBus.score_changed.disconnect(set_score)
