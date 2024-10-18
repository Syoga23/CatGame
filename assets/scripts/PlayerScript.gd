extends Area2D

var motion = Vector2()

@onready var PBasis: Sprite2D = %PlayerBasis
@onready var Hurt_Sound: AudioStreamPlayer = $HurtSound
@onready var Bite_Sound: AudioStreamPlayer = $BiteSound
@onready var BodySprite: AnimatedSprite2D = %Body
@onready var HeadSprite: AnimatedSprite2D = %Head
@onready var collision_shape : CollisionShape2D = %PlayerCollisionShape


@export var Speed : int
@export var HealthPoints : int
@export var hunger_decrease_rate: int
@export var threshold = 100

var Score = 0
var vel = 0
var flip_shape = 0
var flip_head = 0
var flip_basis = 0
var flip_sprite = 0
var kostil = 0

func _ready():
	set_process_input(true) 
	flip_shape = collision_shape.position.x
	flip_head = HeadSprite.position.x
	flip_basis = PBasis.position.x
	flip_sprite = PBasis.texture.get_width()

func _process(delta):
	
	motion = Vector2()  

	if Input.is_action_pressed("ui_mouse_left"):
		vel = get_global_mouse_position().x - global_position.x
		if vel > threshold:
			motion.x += 1
			flip_player(true)
		if vel < -threshold:
			motion.x -= 1
			flip_player(false)
	
	if Input.is_action_pressed("ui_select"):
		HealthPoints = 0
		EventBus.health_changed.emit(HealthPoints)
	
	if (HealthPoints <= 0):
		player_death()

	if Input.is_action_pressed("ui_right"):
		motion.x += 1
		flip_player(true)
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1
		flip_player(false)


	motion = motion.normalized() * Speed * delta * 15

	position += motion
	
	var root_count = get_tree().get_root().get_child_count() - 1
	var camera = get_tree().get_root().get_child(root_count).get_node("Camera2D")

	if camera:
		var view = get_viewport_rect().size 
		var camera_position = camera.global_position
		var sprite_half = (kostil * PBasis.scale.x) * 2
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
	HeadSprite.play("Bite")
	EventBus.health_changed.emit(HealthPoints)
	EventBus.score_changed.emit(Score)

func player_death():
	EventBus.game_over.emit()

func flip_player(mirrored: bool):
	BodySprite.flip_h = mirrored
	HeadSprite.flip_h = mirrored
	if mirrored == true:
		kostil = flip_sprite + 33
		PBasis.position.x = flip_basis + 15
		HeadSprite.position.x = flip_head + 15
		collision_shape.position.x = flip_shape + 600
	else:
		kostil = flip_sprite 
		PBasis.position.x = flip_basis
		HeadSprite.position.x = flip_head
		collision_shape.position.x = flip_shape

func _on_timer_timeout():
	HealthPoints -= hunger_decrease_rate
	HealthPoints = clamp(HealthPoints, 0, 100)  
	EventBus.health_changed.emit(HealthPoints)

func _on_cat_animation_finished() -> void:
	print("DONE")
	HeadSprite.play("Idle")
