extends RigidBody2D

@export var gravity = 1.0
var gravity_vector = Vector2(0, gravity)

var score = 0
@export var wall_score = 50
@export var bumper_score = 500

signal ball_score_updated

const score_popup = preload("res://Objects/ScorePopup.tscn")


func _integrate_forces(state):
	self.apply_force(gravity_vector)


func reset(x: float, y: float):
	score = 0
	ball_score_updated.emit()
	$Trail.disable()
	$Trail.clear_trail()
	PhysicsServer2D.body_set_state(
		self.get_rid(),
		PhysicsServer2D.BODY_STATE_TRANSFORM,
		Transform2D.IDENTITY.translated(Vector2(x, y))
	)
	PhysicsServer2D.body_set_state(
		self.get_rid(),
		PhysicsServer2D.BODY_STATE_LINEAR_VELOCITY,
		Transform2D.IDENTITY.translated(Vector2(0, 0))
	)
	PhysicsServer2D.body_set_state(
		self.get_rid(),
		PhysicsServer2D.BODY_STATE_ANGULAR_VELOCITY,
		Transform2D.IDENTITY.translated(Vector2(0, 0))
	)
	$Trail.enable()


func _on_body_entered(body):
	if body.is_in_group("Wall"):
		increase_ball_score(wall_score)
		$SFX/HitWall.play()
	elif body.is_in_group("Paddle"):
		$SFX/HitPaddle.play()
	elif body.is_in_group("Net"):
		$SFX/HitNet.play()
	elif body.is_in_group("Bumper"):
		increase_ball_score(bumper_score)
		$SFX/HitBumper.play()


func increase_ball_score(points):
	score += points
	ball_score_updated.emit()
	var popup = score_popup.instantiate()
	popup.set_initial_position(global_position)
	popup.set_text("+" + str(points))
	popup.animate()
	get_parent().add_child(popup)

func explode():
	$SFX/Explode.play()
