extends Node2D

@export var paddle_start_position = 250

var p1_score = 0
var p2_score = 0
@export var points_to_win = 10
@export var reset_round_delay = 4


func _input(event):
	if event.is_action_pressed("reset"):
		reset_game()


func _ready():
	reset_round()


func reset_game():
	p1_score = 0
	p2_score = 0
	
	$HUD.update_score(1, p1_score)
	$HUD.update_score(2, p2_score)
	
	reset_round()


func _on_ball_fallen_p1_side():
	$Ball.explode()
	p2_score += 1
	$HUD.update_score(2, p2_score)
	if p1_score >= points_to_win:
		end_game(2)
	else:
		$HUD.display_message("Player %d scores!" % 2)
		await wait(reset_round_delay)
		reset_round(1)


func _on_ball_fallen_p2_side():
	$Ball.explode()
	p1_score += 1
	$HUD.update_score(1, p1_score)
	if p1_score >= points_to_win:
		end_game(1)
	else:
		$HUD.display_message("Player %d scores!" % 1)
		await wait(reset_round_delay)
		reset_round(2)


func end_game(winner: int):
	$HUD.display_message("Player %d wins!" % winner)
	


func wait(seconds):
	await get_tree().create_timer(seconds).timeout


## Reset the round for the next serve.
## Pass nothing to `serving_player` to randomize the player with the serve.
## Otherwise, pass 1 or 2 to give that player the serve.
func reset_round(serving_player=-1):
	print("Resetting round")
	$P1_Paddle.position = Vector2(-paddle_start_position, 250)
	$P2_Paddle.position = Vector2(paddle_start_position, 250)
	
	if serving_player != 1 and serving_player != 2:
		serving_player = randi_range(1, 2)
	if serving_player == 1:
		$Ball.reset(-paddle_start_position, -4)
	elif serving_player == 2:
		$Ball.reset(paddle_start_position, -4)
	
	$DeathBarrier.reset_collision()
	
	$HUD.clear_message()


func _on_death_barrier_fallen_p2_side() -> void:
	pass # Replace with function body.
