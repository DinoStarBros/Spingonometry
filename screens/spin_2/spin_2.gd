extends Control
class_name Spingononmetry2

@onready var wheel_visual: WheelVisual = %wheel_visual
@onready var wheel_rot_accel_timer: Timer = %wheel_rot_accel_timer

var last_sector : int = -1

const wheelRotVel_Range : Vector2 = Vector2(1000, 2000)
const wheelRotAccelTime_Range : Vector2 = Vector2(1,2)

func _ready() -> void:
	wheel_rot_accel_timer.timeout.connect(_wheel_rot_accel_timer_timeout)

func _process(delta: float) -> void:
	_sector_handling()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("spin") and !wheel_visual.is_rotation_accelerating:
		_spin()
	
	if Input.is_action_just_pressed("ESC"):
		Global.change_scene("res://screens/title/title_screen.tscn")

func _wheel_rot_accel_timer_timeout() -> void:
	wheel_visual.is_rotation_accelerating = false

func _sector_handling() -> void:
	var wheel_rotation : float = fmod(wheel_visual.rotation_degrees, 360)
	var current_sector : int = int(wheel_rotation / 60)
	
	
	if current_sector != last_sector:
		%spinClick.pitch_scale = randf_range(4.8, 5.2)
		%spinClick.play()
		%arrownim.play("nod")
		last_sector = current_sector

func _spin() -> void:
	wheel_visual.rotation_velocity = randf_range(wheelRotVel_Range.x, wheelRotVel_Range.y)
	wheel_visual.is_rotation_accelerating = true
	wheel_rot_accel_timer.start(randf_range(wheelRotAccelTime_Range.x, wheelRotAccelTime_Range.y))
