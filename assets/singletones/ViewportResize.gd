extends Node

var ViewportFlag = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	#get_tree().get_root().size_changed.connect(resize)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func resize() -> void:
	get_viewport().size = DisplayServer.screen_get_size()
