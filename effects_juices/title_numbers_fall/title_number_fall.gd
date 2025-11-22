extends Node2D
## Numbers that spawn & fall around the top of the title screen
## To add visual flair & stuff
class_name TitleNumberFall

var symbols : Array = [
	0,1,2,3,4,5,6,7,8,9,10,
	
	"+", "-", "/", "x",
	
	"f(x)=2x-3","f(x)=x2+4x+4","2x-3=3-7x","|2x-5|=40","f(x)=5x+3",
	
	"sin(30)","tan(45)","cos(60)","arcsin(90)","csc(15)",
]
var symbol : String
var velocity : Vector2
var label_settings : LabelSettings
var fall_damp : float
var rot : float

func _ready() -> void:
	symbol = str(symbols.pick_random())
	
	%Label.text = str(symbol)
	label_settings = %Label.label_settings
	label_settings.font_size = randi_range(75, 200)
	fall_damp = randf_range(0.5, 2)
	rot = randf_range(-180, 180)
	
	modulate = Color(
		randf_range(0.0, 1.0),
		randf_range(0.0, 1.0),
		randf_range(0.0, 1.0),
		1.0
	)
	
	%lifeTimer.timeout.connect(queue_free)

func _process(delta: float) -> void:
	_move(delta)
	
	velocity.y += Global.GRAVITY * delta * fall_damp
	rotation_degrees += rot * delta

func _move(delta: float) -> void:
	global_position += velocity * delta
