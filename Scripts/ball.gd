extends RigidBody2D

@export var gravity = 1.0
var gravity_vector = Vector2(0, gravity)


func _integrate_forces(state):
	self.apply_force(gravity_vector)


func reset(x: float, y: float):
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
		$SFX/HitWall.play()
	elif body.is_in_group("Paddle"):
		$SFX/HitPaddle.play()
	elif body.is_in_group("Net"):
		$SFX/HitNet.play()
	elif body.is_in_group("Bumper"):
		$SFX/HitBumper.play()


func explode():
	$SFX/Explode.play()
