extends Node2D

@export var food_size : float
@export var food_scene: PackedScene

func generate_food(name: String):
	var foods = StaticData.food_data["foods"]
	var found_data = null
	for Ifood in foods:
		if Ifood["name"] == name:
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
			print(food_half_width)
			var x_position = randf_range(camera_position.x + food_half_width, viewport_size.x - food_half_width)
			food_instance.position = Vector2(x_position, camera_position.y)


func _on_timer_timeout():
	generate_food("wine")
	generate_food("beer")
	generate_food("chicken")
	generate_food("steakblanca")
	generate_food("whiskey")
	generate_food("sushi")
