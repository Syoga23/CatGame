extends Node

signal score_changed(score : int)
signal health_changed(points : int)
signal game_over()
signal food_gen_timer(time : float)
signal food_gen_order(level : int)
signal is_mute(muted : bool)
signal send_lb_data(data : Array)
