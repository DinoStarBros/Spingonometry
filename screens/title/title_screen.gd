extends Control

var num_fall_txt_scn : PackedScene = preload("res://effects_juices/title_numbers_fall/title_number_fall.tscn")

func _ready() -> void:
	SceneManager.fade_in()
	%numFallSpawnTimer.timeout.connect(_numfall_timer_timeout)
	
	
	%play.pressed.connect(_on_play_pressed)
	%how2play.pressed.connect(_how2play_pressed)
	%quit.pressed.connect(_on_quit_pressed)

func _on_play_pressed() -> void:
	#Global.change_scene("res://screens/spingonometry/spingonometry.tscn")
	Global.change_scene("res://screens/spingonometry/spingonometry.tscn")

func _how2play_pressed() -> void:
	pass

func _on_quit_pressed() -> void:
	get_tree().quit()


func _numfall_timer_timeout() -> void:
	for n in randi_range(1, 3):
		spawn_num_fall_txt()

func spawn_num_fall_txt() -> void:
	var num_fall_txt : TitleNumberFall = num_fall_txt_scn.instantiate()
	num_fall_txt.global_position.y = -200
	num_fall_txt.global_position.x = randf_range(0, 1920)
	add_child(num_fall_txt)
	
	%numFallSpawnTimer.start(randf_range(.5, 2))
