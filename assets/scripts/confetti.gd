extends Node2D

@onready var red = %red
@onready var green = %green
@onready var yellow = %yellow

func emit():
	red.emitting = true
	green.emitting = true
	yellow.emitting = true
