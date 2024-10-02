extends CharacterBody2D

var speed = 799
var motion = Vector2()

const SPRITE_WIDTH = 400.0  #костыль

func _process(delta):
	motion = Vector2()  

	if Input.is_action_pressed("ui_right"):
		motion.x += 1
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1

	motion = motion.normalized() * speed

	move_and_slide()  

	var camera = get_tree().get_root().get_child(0).get_node("Camera2D")
	
	if camera:
		var camera_position = camera.position
		var viewport_size = get_viewport().size

		var sprite_half_width = SPRITE_WIDTH / 2 * camera.zoom.x
		
		var left_bound = camera_position.x - viewport_size.x + sprite_half_width
		var right_bound = camera_position.x + viewport_size.x - sprite_half_width

		position.x = clamp(position.x, left_bound, right_bound)

	position += motion * delta
