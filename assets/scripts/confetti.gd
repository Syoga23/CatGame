extends Node2D

@onready var red = %red
@onready var green = %green
@onready var yellow = %yellow
@onready var blue = %blue
@onready var purple = %purple
@onready var orange = %orange

func _ready() -> void:
	var viewport_size = get_viewport_rect().size
	position = Vector2(0, viewport_size.y)

func emit():
	red.emitting = true
	green.emitting = true
	yellow.emitting = true
	blue.emitting = true
	purple.emitting = true
	orange.emitting = true
