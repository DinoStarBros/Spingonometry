extends Control
class_name Spingononmetry2

@onready var sect_6_wheel: Sect6Wheel = %sect6_wheel
@onready var wheel_rot_accel_timer: Timer = %wheel_rot_accel_timer
@onready var arrow: Sprite2D = %arrow
@onready var angles_arrays: AngleArrays = %angles_arrays
@onready var angle_arrow_pivot: Node2D = %angle_arrow_pivot
@onready var angle_label: Label = %angle_label
@onready var trig_func_label: Label = %trig_func_label
@onready var get_problem_button: TouchScreenButton = %get_problem
@onready var start_timer_button: TouchScreenButton = %start_timer
@onready var answers_arrays: AnswersArrays = %answers_arrays
@onready var answer_label: Label = %answer_label
@onready var answer_timer: Timer = %answer_timer
@onready var time_left_label: Label = %time_left_label

enum difficulties {
	EASY, MEDIUM, HARD
}
enum angle_modes {
	DEGREES, RADIANS
}
enum trig_funcs {
	SIN, COS, TAN, CSC, SEC, COT
}

var current_difficulty : difficulties = difficulties.HARD
var current_angle_mode : angle_modes = angle_modes.DEGREES
var current_trig_func : trig_funcs = trig_funcs.SIN
var last_sector : int = -1
var desired_rot_deg_arrow_ap : float
var time_started : float
var angle_index : int
var show_answer : bool = false

const wheelRotVel_Range : Vector2 = Vector2(1000, 2000)
const wheelRotAccelTime_Range : Vector2 = Vector2(1,2)
const difficulty_times : Dictionary = {
	"easy": 15.0,
	"medium": 30.0,
	"hard": 60.0
}

func _ready() -> void:
	wheel_rot_accel_timer.timeout.connect(_wheel_rot_accel_timer_timeout)
	arrow.global_position.y = sect_6_wheel.global_position.y
	answer_timer.timeout.connect(_answer_times_up)

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
	
	angle_arrow_pivot.rotation_degrees = lerp(angle_arrow_pivot.rotation_degrees, desired_rot_deg_arrow_ap, 3 * delta)
	#trig_func_label.visible = !sect_6_wheel.is_spinning
	
	if sect_6_wheel.is_spinning:
		get_problem_button.global_position = get_problem_button.global_position.lerp(
			Vector2(get_problem_button.global_position.x, 1500), 12 * delta)
		
		start_timer_button.global_position = start_timer_button.global_position.lerp(
			Vector2(start_timer_button.global_position.x, 1500), 12 * delta)
		
	else:
		get_problem_button.global_position = get_problem_button.global_position.lerp(
			Vector2(get_problem_button.global_position.x, 889), 12 * delta)
		
		start_timer_button.global_position = start_timer_button.global_position.lerp(
			Vector2(start_timer_button.global_position.x, 889), 12 * delta)
	
	angle_label.visible = !sect_6_wheel.is_spinning
	answer_label.visible = !sect_6_wheel.is_spinning and show_answer
	
	if !sect_6_wheel.is_spinning:
		_get_answer()
	
	time_left_label.text = str(
		snappedf(answer_timer.time_left, 0.01)
		)
	time_left_label.visible = (answer_timer.time_left) > 0.1

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("spin") and !sect_6_wheel.is_rotation_accelerating:
		answer_label.hide()
		_spin()
		_deg_or_rad()
		_choose_angle()
	
	if Input.is_action_just_pressed("ESC"):
		Global.change_scene("res://screens/title/title_screen.tscn")
	
	if Input.is_action_just_pressed("start_timer"):
		_start_timer()

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
	
	current_trig_func = current_sector as trig_funcs
	#prints(current_sector, current_trig_func)
	match current_trig_func:
		trig_funcs.SIN:
			trig_func_label.text = str("SIN")
		trig_funcs.COS:
			trig_func_label.text = str("COS")
		trig_funcs.TAN:
			trig_func_label.text = str("TAN")
		trig_funcs.CSC:
			trig_func_label.text = str("CSC")
		trig_funcs.SEC:
			trig_func_label.text = str("SEC")
		trig_funcs.COT:
			trig_func_label.text = str("COT")

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

func _choose_angle() -> void:
	angle_index = randi_range(0,32)
	
	desired_rot_deg_arrow_ap = -angles_arrays.degree_floats[angle_index]
	
	if current_angle_mode == angle_modes.DEGREES:
		angle_label.text = str(angles_arrays.degrees_strings[angle_index])
	else:
		angle_label.text = str(angles_arrays.radians_strings[angle_index])

func _get_answer() -> void:
	
	answer_label.text = str(
		"Final answer:
		", 
		answers_arrays.trig_funcs_array[current_trig_func][angle_index]
	)

func _start_timer() -> void:
	match current_difficulty:
		difficulties.EASY:
			answer_timer.start(difficulty_times["easy"])
		difficulties.MEDIUM:
			answer_timer.start(difficulty_times["medium"])
		difficulties.HARD:
			answer_timer.start(difficulty_times["hard"])

func _answer_times_up() -> void:
	pass
