extends Node2D

@export var move_speed = 500

var left_flipper: AnimatableBody2D
var right_flipper: AnimatableBody2D
@export var flip_speed = 500
## Flip angle in degrees
@export var flip_angle = 45.0

## Does this paddle belong to player 1, or player 2?
@export var player = 1
## Left boundary for this paddle
@export var left_bound = -10.0
## Right boundary for this paddle
@export var right_bound = 10.0

var left_flipper_flipped = false
var right_flipper_flipped = false
var left_flipper_rotation_direction = 0
var right_flipper_rotation_direction = 0

func _ready():
	left_flipper = get_node("LeftFlipper")
	right_flipper = get_node("RightFlipper")


func _input(event):
	if player == 1:
		if (event.is_action_pressed("p1_flip_left") or event.is_action_pressed("p1_flip_both")) and not left_flipper_flipped:
			left_flipper_flipped = true
			left_flipper_rotation_direction = 1
		if (event.is_action_pressed("p1_flip_right") or event.is_action_pressed("p1_flip_both")) and not right_flipper_flipped:
			right_flipper_flipped = true
			right_flipper_rotation_direction = -1
		if (event.is_action_released("p1_flip_left") or event.is_action_released("p1_flip_both")) and left_flipper_flipped:
			left_flipper_flipped = false
			left_flipper_rotation_direction = -1
		if (event.is_action_released("p1_flip_right")  or event.is_action_released("p1_flip_both")) and right_flipper_flipped:
			right_flipper_flipped = false
			right_flipper_rotation_direction = 1
	elif player == 2:
		if (event.is_action_pressed("p2_flip_left") or event.is_action_pressed("p2_flip_both")) and not left_flipper_flipped:
			left_flipper_flipped = true
			left_flipper_rotation_direction = 1
		if (event.is_action_pressed("p2_flip_right") or event.is_action_pressed("p2_flip_both")) and not right_flipper_flipped:
			right_flipper_flipped = true
			right_flipper_rotation_direction = -1
		if (event.is_action_released("p2_flip_left") or event.is_action_released("p2_flip_both")) and left_flipper_flipped:
			left_flipper_flipped = false
			left_flipper_rotation_direction = -1
		if (event.is_action_released("p2_flip_right") or event.is_action_released("p2_flip_both")) and right_flipper_flipped:
			right_flipper_flipped = false
			right_flipper_rotation_direction = 1


func _process(delta):
	var velocity = Vector2.ZERO
	
	if player == 1:
		if Input.is_action_pressed("p1_move_left"):
			velocity.x -= move_speed;
		if Input.is_action_pressed("p1_move_right"):
			velocity.x += move_speed;
	elif player == 2:
		if Input.is_action_pressed("p2_move_left"):
			velocity.x -= move_speed;
		if Input.is_action_pressed("p2_move_right"):
			velocity.x += move_speed;
			
	if left_flipper_rotation_direction != 0:
		left_flipper.rotation_degrees += left_flipper_rotation_direction * flip_speed * delta
		left_flipper.rotation_degrees = clampf(left_flipper.rotation_degrees, 0, flip_angle)
		if left_flipper.rotation_degrees == 0 or left_flipper.rotation_degrees == flip_angle:
			left_flipper_rotation_direction = 0
			
	if right_flipper_rotation_direction != 0:
		right_flipper.rotation_degrees += right_flipper_rotation_direction * flip_speed * delta
		right_flipper.rotation_degrees = clampf(right_flipper.rotation_degrees, -flip_angle, 0)
		if right_flipper.rotation_degrees == 0 or right_flipper.rotation_degrees == flip_angle:
			right_flipper_rotation_direction = 0
			
		
	if velocity.length() > 0:
		#position.x += velocity.x * delta
		position.x += velocity.x * delta
		position.x = clampf(position.x, left_bound, right_bound)
