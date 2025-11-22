extends Node2D


func _ready() -> void:
	%"1".pressed.connect(force_1)
	%"2".pressed.connect(force_2)
	%"3".pressed.connect(force_3)
	%"4".pressed.connect(force_4)
	%"5".pressed.connect(force_5)
	%"6".pressed.connect(force_6)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ESC"):
		Global.change_scene("res://screens/title/title_screen.tscn")

func force_1() -> void:
	Global.change_scene(GScnRef.screen["f1"])

func force_2() -> void:
	Global.change_scene(GScnRef.screen["f2"])

func force_3() -> void:
	Global.change_scene(GScnRef.screen["f3"])

func force_4() -> void:
	Global.change_scene(GScnRef.screen["f4"])

func force_5() -> void:
	Global.change_scene(GScnRef.screen["f5"])

func force_6() -> void:
	Global.change_scene(GScnRef.screen["f6"])
