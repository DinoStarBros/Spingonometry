extends Control

var show_answer : bool = false

var question_index : int = 0
var rand_questions : Array[String] = [
	"Arcsin(1)",
	"Arcsin(1/2)",
	"Arcsin(√3/2)",
	"Arcsin(0)",
	"Arcsin(-1/2)",

	"Arccos(1)",
	"Arccos(1/2)",
	"Arccos(0)",
	"Arccos(-1/2)",
	"Arccos(-1)",

	"Arctan(1)",
	"Arctan(√3)",
	"Arctan(1/√3)",
	"Arctan(0)",
	"Arctan(-1)"
]

var answers : Array[String] = [
	"90",
	"30",
	"60",
	"0",
	"-30",

	"0",
	"60",
	"90",
	"120",
	"180",

	"45",
	"60",
	"30",
	"0",
	"-45"
]

func _ready() -> void:
	question_index = randi_range(0,answers.size()-1)

func _process(_delta: float) -> void:
	%question.text = rand_questions[question_index]
	%answer.text = answers[question_index]
	
	%answer.visible = show_answer
	
	if Input.is_action_just_pressed("space"):
		show_answer = not show_answer
	
	if Input.is_action_just_pressed("ESC"):
		Global.change_scene("res://screens/spingonometry/spingonometry.tscn")
