extends Node2D

@export var food_size : float
@export var food_scene: PackedScene

@onready var Timer1 : Timer = %Timer

#0 easy, 1 medium, 2 hard, 3 infinity
var level = 0

var levels = StaticData.level_data["levels"]

var spawn_food : Array

func generate_food(id: int):
	var foods = StaticData.food_data["foods"]
	var found_data = null
	for Ifood in foods:
		if Ifood["id"] == id:
			found_data = Ifood
			break
	if found_data:
		var food_instance = food_scene.instantiate()
		var root_count = get_tree().get_root().get_child_count() - 1
		var camera = get_tree().get_root().get_child(root_count).get_node("Camera2D")
		var sprite: Sprite2D = food_instance.get_child(0).get_node("Sprite2D")
		if camera:
			var camera_position = camera.position
			var viewport_size = get_viewport().size
			food_instance.scale = Vector2(food_size, food_size)
			add_child(food_instance)
			randomize()
			food_instance.init_food(found_data)
			var food_half_width = (sprite.texture.get_width() * food_instance.scale.x) / 2
			var food_half_height = (sprite.texture.get_height() * food_instance.scale.y) / 2
			var x_position = randf_range(camera_position.x + food_half_width, viewport_size.x - food_half_width)
			food_instance.position = Vector2(x_position, camera_position.y-food_half_height)
			

func change_timer_delay(time: float):
	Timer1.wait_time = time / 1000

func _on_timer_timeout():
	#bug with out of bounds
	#Out of bounds get index '6' (on base: 'Array')
	for x in spawn_food.size():
		#print(x, " ", spawn_food.size())
		generate_food(spawn_food[x])
		await get_tree().create_timer(randf() * 0.25).timeout 
	change_order()
		

func change_order():
	#print(spawn_food)
	spawn_food = []
	var food_type_chance = 0
	food_type_chance = 1 - (float(levels[level]["food_chance_modifier"])/100)
	for i in range(levels[level]["food_count"]):
		randomize()
		var random_num = randf()
		if(random_num < food_type_chance):
			pick_food(0)
		else:
			pick_food(1)

func pick_food(type : int):
	var count = 0
	var whitelist = []
	if type == 0:
		var chances = StaticData.chances_data["bad_food"][level]["chances"]
		for key in chances:
			
			#{"id": 0, "type": "S", "chance": 0.0} 5
			for x in levels[level]["food_types"].size():
				if key["id"] == levels[level]["food_types"][x]:
					randomize()
					var random = randf()
					whitelist.append(key["id"])
					if(random < key["chance"]):
						spawn_food.append(key["id"])
						count += 1
						return
		if count == 0:
			
			spawn_food.append(whitelist[randi() % whitelist.size()]) 

	elif type == 1:
		var chances = StaticData.chances_data["good_food"][level]["chances"]
		for key in chances:
			#{"id": 0, "type": "S", "chance": 0.0} 5
			for x in levels[level]["food_types"].size():
				if key["id"] == levels[level]["food_types"][x]:
					randomize()
					var random = randf()
					whitelist.append(key["id"])
					if(random < key["chance"]):
						spawn_food.append(key["id"])
						count += 1
						return
		if count == 0:
			spawn_food.append(whitelist[randi() % whitelist.size()]) 

func set_order(xp : int): 
	level = xp

func _on_tree_entered():
	EventBus.food_gen_timer.connect(change_timer_delay)
	EventBus.food_gen_order.connect(set_order)


func _on_tree_exiting():
	EventBus.food_gen_timer.disconnect(change_timer_delay)
	EventBus.food_gen_order.disconnect(set_order)

"""
func test():
	generate_food(0)
	generate_food(1)
	generate_food(2)
	generate_food(3)
	generate_food(4)
	generate_food(5)
	generate_food(6)
	generate_food(7)
	generate_food(8)
	generate_food(9)
	generate_food(10)
	generate_food(11)
	generate_food(12)
"""
