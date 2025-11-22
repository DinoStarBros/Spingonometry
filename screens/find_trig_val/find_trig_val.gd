extends Node2D

var question_index : int = 0
var rand_questions : Array[String] = [
	"Tan(45)",
	"Cos(270)",
	"Sin(30)",
]
var answers : Array[String] = [
	"1",
	"0",
	"1/2"
]

func _ready() -> void:
	question_index = randi_range(0,2)

var show_answer : bool = false
func _process(_delta: float) -> void:
	%question.text = rand_questions[question_index]
	%answer.text = answers[question_index]
	
	%answer.visible = show_answer
	
	if Input.is_action_just_pressed("space"):
		show_answer = not show_answer
	if Input.is_action_just_pressed("ESC"):
		Global.change_scene("res://screens/spingonometry/spingonometry.tscn")
