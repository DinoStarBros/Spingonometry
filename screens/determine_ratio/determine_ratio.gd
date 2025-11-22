extends Node2D

var question_index : int

var possible_questions : Array[String] = [
	"? = O / H",
	"? = A / H",
	"? = O / A",
	"? = H / O",
	"? = H / A",
	"? = A / O",
]

var answers : Array[String] = [
	"Sine",
	"Cosine",
	"Tangent",
	"Cosecant",
	"Secant",
	"Cotangent",
]
func _ready() -> void:

	question_index = randi_range(0, 5)

var show_answer : bool = false
func _process(_delta: float) -> void:
	%question.text = str(possible_questions[question_index])
	%answer.text = str(answers[question_index])
	
	%answer.visible = show_answer
	
	if Input.is_action_just_pressed("space"):
		show_answer = not show_answer
	if Input.is_action_just_pressed("ESC"):
		Global.change_scene("res://screens/spingonometry/spingonometry.tscn")
