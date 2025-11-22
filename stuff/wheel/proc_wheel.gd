@tool
extends Node2D

const COLORS = [
	Color.RED,
	Color.BLUE,
	Color.GREEN,
	Color.YELLOW,
	Color.ORANGE,
	Color.PURPLE,
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
