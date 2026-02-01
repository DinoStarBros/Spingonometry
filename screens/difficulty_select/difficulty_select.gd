extends Control
class_name DifficultySelect

func _ready() -> void:
	%easy.pressed.connect(_easy_pressed)
	%medium.pressed.connect(_medium_pressed)
	%hard.pressed.connect(_hard_pressed)

func _input(event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("ESC"):
		Global.change_scene("res://screens/title/title_screen.tscn")

func _easy_pressed() -> void:
	Global.current_difficulty = Global.difficulties.EASY
	Global.change_scene("res://screens/spin_2/spin_2.tscn")

func _medium_pressed() -> void:
	Global.current_difficulty = Global.difficulties.MEDIUM
	Global.change_scene("res://screens/spin_2/spin_2.tscn")

func _hard_pressed() -> void:
	Global.current_difficulty = Global.difficulties.HARD
	Global.change_scene("res://screens/spin_2/spin_2.tscn")
