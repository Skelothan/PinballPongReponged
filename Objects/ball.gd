extends RigidBody2D

@export var gravity = 1.0
var gravity_vector = Vector2(0, gravity)

var reset_flag = false

func _integrate_forces(state):
	if reset_flag:
		state.linear_velocity = Vector2.ZERO
		state.angular_velocity = 0
		reset_flag = false
	else:
		self.apply_force(gravity_vector)

func reset():
	reset_flag = true
