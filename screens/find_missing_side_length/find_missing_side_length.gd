extends Control

func _ready() -> void:
	generate_pythag_question()
	print(round_to_dec(10.2345, 3))

var show_answer : bool
func _process(_delta: float) -> void:
	#%answer.text
	
	%answer.visible = show_answer
	
	if Input.is_action_just_pressed("space"):
		show_answer = not show_answer
	
	if Input.is_action_just_pressed("ESC"):
		Global.change_scene("res://screens/spingonometry/spingonometry.tscn")

func generate_pythag_question():
	# Pick a triangle label prefix, e.g., "45"

	# Step 1: Randomly generate two sides (5–20 for example)
	var side_a = randi() % 16 + 5  # 5 to 20
	var side_b = randi() % 16 + 5

	# Step 2: Calculate hypotenuse
	var side_c = sqrt(side_a * side_a + side_b * side_b)

	# Step 3: Pick a side to hide randomly: 0 = a, 1 = b, 2 = c
	var hide_index = randi() % 3

	# Step 4: Assign values to labels
	var label_a = %"45sidea"
	var label_b = %"45sideb"
	var label_c = %"45sidec"

	match hide_index:
		0:
			label_a.text = "?"  # hide a
			label_b.text = str(side_b)
			label_c.text = str(round_to_dec(side_c, 2))
		1:
			label_a.text = str(side_a)
			label_b.text = "?"  # hide b
			label_c.text = str(round_to_dec(side_c, 2))
		2:
			label_a.text = str(side_a)
			label_b.text = str(side_b)
			label_c.text = "?"  # hide c
	
	# Step 5: Return the answer
	var answer
	match hide_index:
		0: answer = side_a
		1: answer = side_b
		2: answer = side_c
	
	%answer.text = str("≈", answer)

func round_to_dec(num, decimals):
	num = float(num)
	decimals = int(decimals)
	var sgn = 1
	if num < 0:
			sgn = -1
			num = abs(num)
			pass
	var num_fraction = num - int(num) 
	var num_dec = round(num_fraction * pow(10.0, decimals)) / pow(10.0, decimals)
	var round_num = sgn*(int(num) + num_dec)
	return round_num
