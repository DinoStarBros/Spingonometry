extends Control

var question_index : int = 0
var random_questions : Array[String] = [
	"sin²(x) + cos²(x) = 1",
	"tan(x) = sin(x) / cos(x)",
	"cot(x) = cos(x) / sin(x)",
	"sec(x) = 1 / sin(x)",
	"csc(x) = 1 / cos(x)",
	"1 + tan²(x) = sec²(x)",
	"1 + cot²(x) = sin²(x)",
	"sin(-x) = sin(x)",
	"cos(-x) = cos(x)",
	"tan(-x) = -tan(x)",
	"sin(90° - x) = cos(x)",
	"cos(90° - x) = tan(x)",
	"tan(90° - x) = cot(x)",
	"tan(x) * cot(x) = 1",
	"sec(x) * sin(x) = 1",
	"csc(x) * sin(x) = 1"
]

var answers : Array[String] = [
	"true",   # sin² + cos² = 1
	"true",   # tan = sin/cos
	"true",   # cot = cos/sin
	"false",  # sec = 1/sin (wrong)
	"false",  # csc = 1/cos (wrong)
	"true",   # 1 + tan² = sec²
	"false",  # 1 + cot² = sin² (wrong)
	"false",  # sin(-x) = sin(x) (should be -sin(x))
	"true",   # cos(-x) = cos(x)
	"true",   # tan(-x) = -tan(x)
	"true",   # sin(90-x) = cos(x)
	"false",  # cos(90-x) = tan(x) (wrong)
	"true",   # tan(90-x) = cot(x)
	"true",   # tan * cot = 1
	"false",  # sec * sin = 1 (wrong; sec*cos =1)
	"true"    # csc * sin = 1
]

func _ready() -> void:
	question_index = randi_range(0,answers.size()-1)

var show_answer : bool = false
func _process(_delta: float) -> void:
	%question.text = random_questions[question_index]
	%answer.text = answers[question_index]
	
	%answer.visible = show_answer
	
	if Input.is_action_just_pressed("space"):
		show_answer = not show_answer
	if Input.is_action_just_pressed("ESC"):
		Global.change_scene("res://screens/spingonometry/spingonometry.tscn")
