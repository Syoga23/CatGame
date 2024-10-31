extends Node2D

@onready var leftWall = %WallLeft
@onready var bottomWall = %WallBottom
@onready var rightWall = %WallRight

@export var steak : PackedScene
@onready var conf1 = $Confetti
@onready var conf2 = $Confetti2

var viewport_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport_size = get_viewport_rect().size
	conf2.position.x = viewport_size.x
	set_walls()
	spawn_steaks(100)
	#get_node("UI/Control").
	conf1.emit()
	conf2.emit()

func _input(event: InputEvent) -> void:
	if event.is_action("ui_mouse_left"):
		get_tree().change_scene_to_file("res://assets/scenes/main_menu.tscn")

func spawn_steaks(count : int):
	randomize()
	for i in range(count):
		var ball = steak.instantiate()
		# Случайное положение для шара
		ball.position = Vector2(viewport_size.x/2 - randf_range(0, 200), -100 - randf_range(50, 50))
		ball.rotation = randf_range(-360, 360)
		ball.add_to_group("balls")
		add_child(ball)
		await get_tree().create_timer(0.1).timeout
	await get_tree().create_timer(5).timeout
	remove_all_balls()

func set_walls() -> void:
	leftWall.position = Vector2(0, viewport_size.y)
	bottomWall.position = Vector2(viewport_size.x, viewport_size.y)
	rightWall.position = Vector2(viewport_size.x, viewport_size.y)
	leftWall.scale = Vector2(1, viewport_size.y)
	bottomWall.scale = Vector2(viewport_size.x, 1)
	rightWall.scale = Vector2(1, viewport_size.y)

func remove_all_balls():
	var balls = get_tree().get_nodes_in_group("balls")
	for ball in balls:
		ball.queue_free()  # Удаляем шар

func _on_timer_timeout() -> void:
	
	pass
