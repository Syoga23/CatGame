extends Area2D

var motion = Vector2()

@onready var sprite_2d: Sprite2D = $PlayerBasis
@onready var Hurt_Sound: AudioStreamPlayer = $HurtSound
@onready var Bite_Sound: AudioStreamPlayer = $BiteSound

@export var Speed : int
@export var HealthPoints : int
@export var hunger_decrease_rate: int
@export var threshold = 100

var Score = 0

func _ready():
	set_process_input(true) 

func _process(delta):
	
	motion = Vector2()  
	
	if Input.is_action_pressed("ui_select"):
		HealthPoints = 0
		EventBus.health_changed.emit(HealthPoints)
	
	if (HealthPoints <= 0):
		player_death()

	if Input.is_action_pressed("ui_mouse_left"):  
		var mouse_position = get_local_mouse_position()
		if mouse_position.x > position.x - threshold:
			motion.x += 1
		
		if mouse_position.x < position.x + threshold:
			motion.x -= 1
		motion = motion * Speed * delta * 15
		position += motion

	if Input.is_action_pressed("ui_right"):
		motion.x += 1
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1

	motion = motion.normalized() * Speed * delta * 15

	position += motion
	
	var root_count = get_tree().get_root().get_child_count() - 1
	var camera = get_tree().get_root().get_child(root_count).get_node("Camera2D")

	if camera:
		
		var view = get_viewport_rect().size 
		var camera_position = camera.global_position
		var sprite_half = (sprite_2d.texture.get_width() * get_parent().scale.x) / 2
		var left_bound = camera_position.x + sprite_half
		var right_bound = view.x - sprite_half
		global_position.x = clamp(global_position.x, left_bound, right_bound)

func food_eaten(saturation: int, score_points: int):
	HealthPoints += saturation
	Score += score_points
	HealthPoints = clamp(HealthPoints, 0, 100) 
	if (saturation < 0):
		Hurt_Sound.play()
	elif(saturation > 0):
		Bite_Sound.play() 
	EventBus.health_changed.emit(HealthPoints)
	EventBus.score_changed.emit(Score)

func player_death():
	EventBus.game_over.emit()

func _on_timer_timeout():
	HealthPoints -= hunger_decrease_rate
	HealthPoints = clamp(HealthPoints, 0, 100)  
	EventBus.health_changed.emit(HealthPoints)

