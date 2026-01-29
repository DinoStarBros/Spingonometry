@tool
extends Node2D
class_name AngleWheel

var rotation_velocity : float
var is_rotation_accelerating : bool = false

var COLORS : Array = [
	Color.WHITE,
	Color.GRAY,
	Color.DIM_GRAY,
	Color.WEB_GRAY,
]

func _draw():
	
	var radius = 200
	var center = Vector2.ZERO
	var slice_angle = 360.0 / COLORS.size()

	for i in range(COLORS.size()):
		var start_angle = deg_to_rad(i * slice_angle)
		var end_angle = deg_to_rad((i + 1) * slice_angle)

		# Create points for a triangle-fan slice
		var points = [center]
		var steps = 20

		for s in range(steps + 1):
			var t = lerp(start_angle, end_angle, s / float(steps))
			points.append(Vector2(cos(t), sin(t)) * radius)

		draw_polygon(points, [COLORS[i]])

func _process(delta: float) -> void:
	_rotate_delta(delta)
	
	if !is_rotation_accelerating:
		rotation_velocity = lerp(rotation_velocity, 0.0, 2 * delta)

func _rotate_delta(delta: float) -> void:
	rotation_degrees = wrapf(rotation_degrees, 0, 360)
	rotation_degrees += rotation_velocity * delta
