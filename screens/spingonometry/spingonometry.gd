extends Control

@onready var wheel: Wheel = %wheel

func _ready() -> void:
	Global.allow_show_answer = false
	
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
	#Global.change_scene(GScnRef.screen["f1"])
	#wheel.wheel.rotation_degrees = 330
	if not wheel.spinning:
		_create_property_tween(wheel.wheel, "rotation_degrees", 330)

func force_2() -> void:
	#Global.change_scene(GScnRef.screen["f2"])
	#wheel.wheel.rotation_degrees = 270
	if not wheel.spinning:
		_create_property_tween(wheel.wheel, "rotation_degrees", 270)

func force_3() -> void:
	#Global.change_scene(GScnRef.screen["f3"])
	#wheel.wheel.rotation_degrees = 210
	if not wheel.spinning:
		_create_property_tween(wheel.wheel, "rotation_degrees", 210)

func force_4() -> void:
	#Global.change_scene(GScnRef.screen["f4"])
	#wheel.wheel.rotation_degrees = 150
	if not wheel.spinning:
		_create_property_tween(wheel.wheel, "rotation_degrees", 150)

func force_5() -> void:
	#Global.change_scene(GScnRef.screen["f5"])
	#wheel.wheel.rotation_degrees = 90
	if not wheel.spinning:
		_create_property_tween(wheel.wheel, "rotation_degrees", 90)

func force_6() -> void:
	#Global.change_scene(GScnRef.screen["f6"])wheel.wheel.rotation_degrees = 30
	#wheel.wheel.rotation_degrees = 30
	if not wheel.spinning:
		_create_property_tween(wheel.wheel, "rotation_degrees", 30)

var tween : Tween
var property_tween : Object
var tween_ease : Object
func _create_property_tween(
	node:Node,
	property: NodePath,
	to:Variant,
	time:float=0.5,
	set_ease:Tween.EaseType=Tween.EASE_IN_OUT,
	set_trans:Tween.TransitionType=Tween.TRANS_SINE
	) -> void:
	
	wheel.scene_just_started = false
	
	if tween:
		tween.kill()
	
	tween = create_tween()
	property_tween = tween.tween_property(node, property, to, time)
	tween_ease = property_tween.set_ease(set_ease)
	tween_ease.set_trans(set_trans)
