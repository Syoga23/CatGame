extends Area2D


var motion = Vector2()

@onready var sprite_2d: Sprite2D = $PlayerBasis
@export var Speed : int
@export var HealthPoints : int
@export var hunger_decrease_rate: int

func _ready():
	pass

func _process(delta):
	
	motion = Vector2()  
	
	if (HealthPoints <= 0):
		player_death()

	if Input.is_action_pressed("ui_right"):
		motion.x += 1
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1

	motion = motion.normalized() * Speed * delta * 15

	position += motion
	
	var camera = get_tree().get_root().get_child(0).get_node("Camera2D")

	if camera:
		
		var view = get_viewport_rect().size 
		var camera_position = camera.global_position
		var sprite_half = (sprite_2d.texture.get_width() * get_parent().scale.x) / 2
		var left_bound = camera_position.x + sprite_half
		var right_bound = view.x - sprite_half
		global_position.x = clamp(global_position.x, left_bound, right_bound)

signal health_changed(points)

func food_eaten(points: int):
	HealthPoints += points
	HealthPoints = clamp(HealthPoints, 0, 100)  
	health_changed.emit(HealthPoints)

func player_death():
	pass

func _on_timer_timeout():
	HealthPoints -= hunger_decrease_rate
	HealthPoints = clamp(HealthPoints, 0, 100)  
	health_changed.emit(HealthPoints)
	print(hunger_decrease_rate)
	print(HealthPoints)
