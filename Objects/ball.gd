extends RigidBody2D

@export var gravity = 1.0
var gravity_vector = Vector2(0, gravity)

func _integrate_forces(state):
	self.apply_force(gravity_vector)
