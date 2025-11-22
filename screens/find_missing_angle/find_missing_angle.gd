extends Node2D

var question_type : bool = false # If false, find the missing angle using two sides and a trigonometric ratio
# If true, find the missing angle using one angle and subtraction
var which_angle : bool = false

var given_angle : int = 0

var length_c: float # hypotenuse
var length_a: float # a
var length_b: float # b
var side_lengths: Array = [
	length_a, length_b, length_c
]
@onready var side_length_labels_45 : Array = [
	%"45sidec", %"45sidea", %"45sideb"
]
@onready var side_length_labels_63 : Array = [
	%"63sidec", %"63sidea", %"63sideb"
]
func _ready() -> void:
	
	question_type = false#randi_range(0,3) == 0
	# Less chance to get a missing angle case w/ trig ratio
	
	#%"45angle1".visible = question_type
	%"45angle2".visible = question_type
	#%"63angle1".visible = question_type
	%"63angle2".visible = question_type
	
	%"45sidec".visible = !question_type
	%"45sidea".visible = !question_type
	%"45sideb".visible = !question_type
	%"63sidec".visible = !question_type
	%"63sidea".visible = !question_type
	%"63sideb".visible = !question_type
	
	if question_type:
		# 1 angle & Subtraction
		given_angle = randi_range(20, 80)
		which_angle = randi_range(0,1) == 0
	else:
		# Lengths & Trig ratio
		length_a = randi_range(10, 50)
		length_b = randi_range(10, 50)
		length_c = sqrt( # Epic pythagoras theorem
			(length_a ** 2) + (length_b ** 2)
		)
		#length_c = round(length_c)
		
		var sl_to_hide : int = randi_range(0,2)
		side_length_labels_45[sl_to_hide].hide()
		side_length_labels_63[sl_to_hide].hide()
		
		answer = str(rad_to_deg(asin(length_b / length_c)))

var show_answer : bool = false
var answer : String
func _process(delta: float) -> void:
	
	if question_type:
		# 1 angle & Subtraction
		subtract_angle()
	else:
		# Lengths & Trig ratio
		trig_length()
	
	
	
	%answer.visible = show_answer
	
	if Input.is_action_just_pressed("space"):
		show_answer = not show_answer
	if Input.is_action_just_pressed("ESC"):
		Global.change_scene(GScnRef.screen["spingonometry"])

func subtract_angle() -> void:
		%"45".visible = given_angle <= 45 # Show 45 angle triangle
		%"6030".visible = given_angle > 45 # Show 6030 angle triangle
		
		answer = str(90 - given_angle)
		%answer.text = str(answer)
		
		if which_angle: # Bottom angle, 
			%"45angle1".text = str(given_angle)
			%"63angle1".text = str(given_angle)
			
			%"45angle2".text = "?"
			%"63angle2".text = "?"
		else: # TOp angle
			%"45angle2".text = str(given_angle)
			%"63angle2".text = str(given_angle)
			
			%"45angle1".text = "?"
			%"63angle1".text = "?"

func trig_length() -> void:
	%"45sidea".text = str(length_a)
	%"45sideb".text = str(length_b)
	%"45sidec".text = str(length_c)
	
	%"63sidea".text = str(length_a)
	%"63sideb".text = str(length_b)
	%"63sidec".text = str(length_c)
	
	%"45angle1".text = "?"
	%"63angle1".text = "?"
	
	%"45".visible = rad_to_deg(asin(length_b / length_c)) <= 45 # Show 45 angle triangle
	%"6030".visible = rad_to_deg(asin(length_b / length_c)) > 45 # Show 6030 angle triangle
	
	%answer.text = str(answer)
