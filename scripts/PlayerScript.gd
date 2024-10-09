extends Area2D

var motion = Vector2()

@onready var sprite_2d: Sprite2D = $PlayerBasis
@onready var Hurt_Sound: AudioStreamPlayer = $HurtSound
@onready var Bite_Sound: AudioStreamPlayer = $BiteSound

@export var Speed : int
@export var HealthPoints : int
@export var hunger_decrease_rate: int

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

	if Input.is_action_pressed("ui_right"):
		motion.x += 1
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1

	motion = motion.normalized() * Speed * delta * 15

	position += motion
	
	#\/\/\/CHANGE DIS PLEASE I BEG YOU USING NUMBERS HERE BAD VERY BAD\/\/\/
	var camera = get_tree().get_root().get_child(2).get_node("Camera2D")

	if camera:
		
		var view = get_viewport_rect().size 
		var camera_position = camera.global_position
		var sprite_half = (sprite_2d.texture.get_width() * get_parent().scale.x) / 2
		var left_bound = camera_position.x + sprite_half
		var right_bound = view.x - sprite_half
		global_position.x = clamp(global_position.x, left_bound, right_bound)

func food_eaten(points: int):
	HealthPoints += points
	HealthPoints = clamp(HealthPoints, 0, 100) 
	if (points < 0):
		Hurt_Sound.play()
	elif(points > 0):
		Bite_Sound.play() 
	EventBus.health_changed.emit(HealthPoints)

func player_death():
	EventBus.game_over.emit(Score)

func _on_timer_timeout():
	HealthPoints -= hunger_decrease_rate
	HealthPoints = clamp(HealthPoints, 0, 100)  
	EventBus.health_changed.emit(HealthPoints)
	print(HealthPoints)

