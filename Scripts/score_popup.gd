extends Node2D

var start_position: Vector2

var upwards_movement = -50
var tween_time = 1.0


func set_initial_position(pos: Vector2):
	global_position = pos
	start_position = pos


func set_text(text: String):
	$Label.text = text


func animate():
	var tween = create_tween()
	tween.tween_property(self, "global_position", start_position + Vector2(0, upwards_movement), tween_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_callback(queue_free)
