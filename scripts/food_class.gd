extends Node2D

class_name Foods

@onready var sprite : Sprite2D = $hitbox/Sprite2D

var score : int
var saturation: int
var food_name : String
var fall_speed: int

func Eaten_By_Player(body):
	if( body.is_in_group("player") ):
		body.food_eaten(saturation)
		#emit score signal
		await get_tree().create_timer(0.02).timeout
		queue_free()

func init_food(food_info: Dictionary):
	self.score = food_info["score"]
	self.saturation = food_info["saturation"]
	self.fall_speed = food_info["fall_speed"]
	var image = "res://textures/food/" + food_info["name"] + ".png"
	sprite.texture = load(image)

