extends Node2D

var question_index : int = 0
var ranodm_questions : Array[String] = [
	"sin² + cos² = ",
	"tan = sin / cos",
	"csc = 1 / cos",
	"csc = 1 / sin"
]
var answers : Array[String] = [
	"false",
	"true",
	"false",
	"true"
]

func _ready() -> void:
	question_index = randi_range(0,3)

var show_answer : bool = false
func _process(_delta: float) -> void:
	%question.text = ranodm_questions[question_index]
	%answer.text = answers[question_index]
	
	%answer.visible = show_answer
	
	if Input.is_action_just_pressed("space"):
		show_answer = not show_answer
	if Input.is_action_just_pressed("ESC"):
		Global.change_scene("res://screens/spingonometry/spingonometry.tscn")
