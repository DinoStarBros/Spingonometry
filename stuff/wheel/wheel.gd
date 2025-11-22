extends Node2D
class_name Wheel

var spinning : bool = false
var rot_vel : float = 0
var fate_accepted : bool = false
var problem_scn_str : String

@onready var wheel: Node2D = %wheel
@onready var debug_txt: Label = %debug_txt

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	%fateSelected.stop()

func start_spin() -> void:
	if not spinning and rot_vel <= 10:
		fate_accepted = false
		rot_vel = randf_range(1500, 2500)
		spinning = true
		%startDecelerateTimer.start(randf_range(0.7,1.2))

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("space"):
		start_spin()
	
	if Input.is_action_just_pressed("Enter") and fate_accepted:
		Global.change_scene(problem_scn_str)

func _process(delta: float) -> void:
	_click_sound_handle()
	
	_rotate_delta(delta)
	
	limit_rotation_wheel()
	
	if rot_vel <= 1:
		determine_fate()
	
	if not spinning:
		rot_vel = lerp(rot_vel, 0.0, 1.2 * delta)
	
	%accept_fate.visible = fate_accepted
	debug_txt.visible = fate_accepted

func _rotate_delta(delta:float) -> void:
	wheel.rotation_degrees += rot_vel * delta

func _on_start_decelerate_timer_timeout() -> void:
	spinning = false

func limit_rotation_wheel() -> void:
	if wheel.rotation_degrees > 360:
		wheel.rotation_degrees = 0
	if wheel.rotation_degrees < 0:
		wheel.rotation_degrees = 360

var quadrants : Array[Vector2] = [
	Vector2(300,360),
	Vector2(240,300),
	Vector2(180,240),
	Vector2(120,180),
	Vector2(60,120),
	Vector2(0,60),
]

func determine_fate() -> void:
	
	if not fate_accepted:
		%fateSelected.play()
	
	fate_accepted = true
	if wheel.rotation_degrees > quadrants[0].x and wheel.rotation_degrees < quadrants[0].y:
		debug_txt.text = "1. Determine the Ratio"
		problem_scn_str = GScnRef.screen["f1"]
		
	elif wheel.rotation_degrees > quadrants[1].x and wheel.rotation_degrees < quadrants[1].y:
		debug_txt.text = "2. Find the missing angle"
		problem_scn_str = GScnRef.screen["f2"]
		
	elif wheel.rotation_degrees > quadrants[2].x and wheel.rotation_degrees < quadrants[2].y:
		debug_txt.text = "3. True or False: Is this trig identity true?"
		problem_scn_str = GScnRef.screen["f3"]
		
	elif wheel.rotation_degrees > quadrants[3].x and wheel.rotation_degrees < quadrants[3].y:
		debug_txt.text = "4. Find the trig value. (e.g. sin(45))"
		problem_scn_str = GScnRef.screen["f4"]
		
	elif wheel.rotation_degrees > quadrants[4].x and wheel.rotation_degrees < quadrants[4].y:
		debug_txt.text = "5. Find the missing side length"
		problem_scn_str = GScnRef.screen["f5"]
		
	elif wheel.rotation_degrees > quadrants[5].x and wheel.rotation_degrees < quadrants[5].y:
		debug_txt.text = "6. Find the inverse trigonometric function value (e.g. arcsin(1))"
		problem_scn_str = GScnRef.screen["f6"]

var click_just_played : bool = false
var last_sector : int = -1
func _click_sound_handle() -> void:
	var rotation_deg : float = fmod(wheel.rotation_degrees, 360)
	var current_sector : int = int(rotation_deg / 60)
	
	if current_sector != last_sector:
		%spinClick.play()
		last_sector = current_sector
