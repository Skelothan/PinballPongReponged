extends Area2D

signal fallen_p1_side
signal fallen_p2_side


func start(_pos):
	reset_collision()


func reset_collision():
	$CollisionShape2D.disabled = false


func _on_body_entered(body: PhysicsBody2D):
	if body.position.x > 0:
		fallen_p2_side.emit()
	else:
		fallen_p1_side.emit()
	
	$CollisionShape2D.set_deferred("disabled", true)
