extends Node2D

var show_answer : bool = false

var question_index : int = 0
var rand_questions : Array[String] = [
	"Arcsin(1)",
	"Arccos(-1)",
	"Arcsin(1/2)",
]
var answers : Array[String] = [
	"90",
	"180",
	"30"
]

func _ready() -> void:
	question_index = randi_range(0,2)

func _process(_delta: float) -> void:
	%question.text = rand_questions[question_index]
	%answer.text = answers[question_index]
	
	%answer.visible = show_answer
	
	if Input.is_action_just_pressed("space"):
		show_answer = not show_answer
	
	if Input.is_action_just_pressed("ESC"):
		Global.change_scene("res://screens/spingonometry/spingonometry.tscn")
