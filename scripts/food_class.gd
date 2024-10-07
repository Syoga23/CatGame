extends Node2D
class_name Foods

@export var nutrition_value: int
@export var food_name : String
@export var fall_speed: float 
@export var hitbox : Area2D

func food_entered_player(body):
	if( body.is_in_group("player") ):
		body.food_eaten(nutrition_value)
		await get_tree().create_timer(0.02).timeout
		queue_free()

	
