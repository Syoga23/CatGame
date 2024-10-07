extends Node2D

@export var food_scene: PackedScene
var spawn_timer = 0.0
const SPAWN_INTERVAL = 1.0

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_timer += delta
	if spawn_timer >= SPAWN_INTERVAL:
		spawn_food()
		spawn_timer = 0.0

func spawn_food():
	var camera = get_tree().get_root().get_child(0).get_node("Camera2D")
	if camera:
		var camera_position = camera.position
		var viewport_size = get_viewport().size

		#add something(food_sprite width for example) to keep food spawning in right places
		var x_position = randf_range(camera_position.x, viewport_size.x)
		var food_instance = food_scene.instantiate() 
		food_instance.position = Vector2(x_position, camera_position.y)
		food_instance.scale = Vector2(5, 5)
		add_child(food_instance)
		
