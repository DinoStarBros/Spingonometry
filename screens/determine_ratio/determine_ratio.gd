extends Control

var question_index : int

var possible_questions : Array[String] = [
	# Basic
	"? = O / H",
	"? = A / H",
	"? = O / A",
	"? = H / O",
	"? = H / A",
	"? = A / O",

	# Spelled Out
	"? = Opposite / Hypotenuse",
	"? = Adjacent / Hypotenuse",
	"? = Opposite / Adjacent",
	"? = Hypotenuse / Opposite",
	"? = Hypotenuse / Adjacent",
	"? = Adjacent / Opposite",

	# Reverse Versions
	"Sin = ?",
	"Cos = ?",
	"Tan = ?",
	"Csc = ?",
	"Sec = ?",
	"Cot = ?",

	# Reverse – Full Word
	"Sine = ?",
	"Cosine = ?",
	"Tangent = ?",
	"Cosecant = ?",
	"Secant = ?",
	"Cotangent = ?",
]

var answers : Array[String] = [
	"Sine",
	"Cosine",
	"Tangent",
	"Cosecant",
	"Secant",
	"Cotangent",

	# Spelled-out versions
	"Sine",
	"Cosine",
	"Tangent",
	"Cosecant",
	"Secant",
	"Cotangent",

	# Reverse Versions (these are the ratios)
	"O / H",
	"A / H",
	"O / A",
	"H / O",
	"H / A",
	"A / O",

	# Reverse – Full Word
	"Opposite / Hypotenuse",
	"Adjacent / Hypotenuse",
	"Opposite / Adjacent",
	"Hypotenuse / Opposite",
	"Hypotenuse / Adjacent",
	"Adjacent / Opposite",
]
func _ready() -> void:
	
	question_index = randi_range(0, answers.size()-1)

var show_answer : bool = false
func _process(_delta: float) -> void:
	%question.text = str(possible_questions[question_index])
	%answer.text = str(answers[question_index])
	
	%answer.visible = show_answer
	
	if Input.is_action_just_pressed("space"):
		show_answer = not show_answer
	
	if Input.is_action_just_pressed("ESC"):
		Global.change_scene("res://screens/spingonometry/spingonometry.tscn")
