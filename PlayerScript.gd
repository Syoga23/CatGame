extends Area2D

var speed = 190
var motion = Vector2()

@onready var sprite_2d: Sprite2D = $PlayerBasis

func _ready():
	pass

func _process(delta):
	motion = Vector2()  

	if Input.is_action_pressed("ui_right"):
		motion.x += 1
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1

	motion = motion.normalized() * speed * delta * 15

	position += motion
	
	var camera = get_tree().get_root().get_child(0).get_node("Camera2D")
	
	if camera:
		
		var view = get_viewport_rect().size 
		var camera_position = camera.global_position
		
		var sprite_half = sprite_2d.texture.get_width() / 12
		#problem with understanding how to restrict player x pos to gamescene bounds
		var left_bound = camera_position.x + sprite_half
		var right_bound = view.x - sprite_half #+ camera_position.x  
		print(sprite_half)
		global_position.x = clamp(global_position.x, left_bound, right_bound)

