extends Node2D

func _ready() -> void:
	pass

var show_answer : bool
func _process(delta: float) -> void:
	%question.text
	%answer.text
	
	%answer.visible = show_answer
	
	if Input.is_action_just_pressed("space"):
		show_answer = not show_answer
	
	if Input.is_action_just_pressed("ESC"):
		Global.change_scene("res://screens/spingonometry/spingonometry.tscn")
