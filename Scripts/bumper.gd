extends StaticBody2D

@export var bumper_strength = 1
@export var animation_scale = 1.5
@export var animation_time = 0.25

var tween: Tween
var outer_circle_default_size: Vector2

func _ready():
	outer_circle_default_size = $OuterCircle.scale


func _on_body_entered(body):
	if body.is_in_group("Ball"):
		var direction = self.global_position.direction_to(body.position)
		body.apply_force(direction.normalized() * bumper_strength)
		animate_bumper()


func animate_bumper():
	if tween:
		tween.kill()
	$OuterCircle.scale = outer_circle_default_size * animation_scale
	tween = create_tween()
	tween.tween_property($OuterCircle, "scale", outer_circle_default_size, animation_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
