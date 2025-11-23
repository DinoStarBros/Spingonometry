extends Control

var question_index : int = 0
var rand_questions : Array[String] = [
	"Sin(0)",
	"Sin(30)",
	"Sin(45)",
	"Sin(60)",
	"Sin(90)",

	"Cos(0)",
	"Cos(30)",
	"Cos(45)",
	"Cos(60)",
	"Cos(90)",

	"Tan(0)",
	"Tan(30)",
	"Tan(45)",
	"Tan(60)",

	"Sin(180)",
	"Cos(180)",
	"Tan(180)",

	"Sin(270)",
	"Cos(270)",

	"Sin(360)",
	"Cos(360)",
	"Tan(360)"
]

var answers : Array[String] = [
	"0",
	"1/2",
	"√2/2",
	"√3/2",
	"1",

	"1",
	"√3/2",
	"√2/2",
	"1/2",
	"0",

	"0",
	"1/√3",   # aka √3/3
	"1",
	"√3",

	"0",
	"-1",
	"0",

	"-1",
	"0",

	"0",
	"1",
	"0"
]

func _ready() -> void:
	question_index = randi_range(0,answers.size()-1)

var show_answer : bool = false
func _process(_delta: float) -> void:
	%question.text = rand_questions[question_index]
	%answer.text = answers[question_index]
	
	%answer.visible = show_answer
	
	if Input.is_action_just_pressed("space"):
		show_answer = not show_answer
	if Input.is_action_just_pressed("ESC"):
		Global.change_scene("res://screens/spingonometry/spingonometry.tscn")
