extends Control
class_name Spingononmetry2

@onready var sect_6_wheel: Sect6Wheel = %sect6_wheel
@onready var wheel_rot_accel_timer: Timer = %wheel_rot_accel_timer
@onready var arrow: Sprite2D = %arrow

enum difficulties {
	EASY, MEDIUM, HARD
}
enum angle_modes {
	DEGREES, RADIANS
}

var current_difficulty : difficulties = difficulties.EASY
var current_angle_mode : angle_modes = angle_modes.DEGREES
var last_sector : int = -1

const wheelRotVel_Range : Vector2 = Vector2(1000, 2000)
const wheelRotAccelTime_Range : Vector2 = Vector2(1,2)

func _ready() -> void:
	wheel_rot_accel_timer.timeout.connect(_wheel_rot_accel_timer_timeout)
	arrow.global_position.y = sect_6_wheel.global_position.y

func _process(delta: float) -> void:
	_sector_handling()
	if current_angle_mode == angle_modes.DEGREES:
		%deg_or_rad.text = str(
			"Angle mode:
			Degrees"
		)
	else:
		%deg_or_rad.text = str(
			"Angle mode:
			Radians"
		)
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("spin") and !sect_6_wheel.is_rotation_accelerating:
		_spin()
		_deg_or_rad()
	
	if Input.is_action_just_pressed("ESC"):
		Global.change_scene("res://screens/title/title_screen.tscn")

func _wheel_rot_accel_timer_timeout() -> void:
	sect_6_wheel.is_rotation_accelerating = false

func _sector_handling() -> void:
	var wheel_rotation : float = fmod(sect_6_wheel.rotation_degrees, 360)
	var current_sector : int = int(wheel_rotation / 60)
	
	
	if current_sector != last_sector:
		%spinClick.pitch_scale = randf_range(4.8, 5.2)
		%spinClick.play()
		%arrownim.stop()
		%arrownim.play("nod")
		last_sector = current_sector

func _spin() -> void:
	sect_6_wheel.rotation_velocity = randf_range(wheelRotVel_Range.x, wheelRotVel_Range.y)
	sect_6_wheel.is_rotation_accelerating = true
	wheel_rot_accel_timer.start(randf_range(wheelRotAccelTime_Range.x, wheelRotAccelTime_Range.y))

func _deg_or_rad() -> void:
	%angle_mode_anim.play("select")
	
	if randi_range(1,3) == 1:
		current_angle_mode = angle_modes.DEGREES
	else:
		current_angle_mode = angle_modes.RADIANS
