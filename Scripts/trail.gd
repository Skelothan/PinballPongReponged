# Followed this tutorial by CoderNunk: https://www.youtube.com/watch?v=Bhc_EBasycY

extends Line2D

@export var curve_length = 50
@onready var curve := Curve2D.new()

func _process(_delta):
	curve.add_point(get_parent().position)
	if curve.get_baked_points().size() > curve_length:
		curve.remove_point(0)

	points = curve.get_baked_points()

func disable():
	set_process(false)

func enable():
	set_process(true)

func clear_trail():
	curve = Curve2D.new()
	
