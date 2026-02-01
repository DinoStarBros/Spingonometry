extends Node

const GRAVITY : float = 490.0

var allow_show_answer : bool = false ## Only true after timer is up
var current_difficulty : Global.difficulties = Global.difficulties.MEDIUM

enum difficulties {
	EASY, MEDIUM, HARD
}

func change_scene(path:String) -> void:
	SceneManager.change_scene(
		path,
		
	)
