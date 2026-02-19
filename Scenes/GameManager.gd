extends Node2D

@export var left_paddle: Node2D
@export var right_paddle: Node2D
@export var ball: Node2D

@export var paddle_start_position = 250

var p1_score = 0
var p2_score = 0
@export var points_to_win = 10
@export var reset_round_delay = 4


func _ready():
	pass
	


func reset_game():
	p1_score = 0
	p2_score = 0
	
	reset_round()


func give_point(player: int):
	if player == 1:
		p1_score += 1
		await wait(reset_round_delay)
		reset_round(2)
	elif player == 2:
		p2_score += 1
		await wait(reset_round_delay)
		reset_round(1)	


func wait(seconds):
	await get_tree().create_timer(seconds)


## Reset the round for the next serve.
## Pass nothing to `serving_player` to randomize the player with the serve.
## Otherwise, pass 1 or 2 to give that player the serve.
func reset_round(serving_player=-1):
	left_paddle.position = Vector2(-paddle_start_position, 250)
	right_paddle.position = Vector2(paddle_start_position, 250)
	
	if serving_player != 1 and serving_player != 2:
		serving_player = randi_range(1, 2)
	if serving_player == 1:
		ball.position = Vector2(-paddle_start_position, -4)
	elif serving_player == 2:
		ball.position = Vector2(paddle_start_position, -4)
	if ball.has_method("reset"):
		ball.reset()
