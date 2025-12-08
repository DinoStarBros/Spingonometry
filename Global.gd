extends Node

const GRAVITY : float = 490.0

var allow_show_answer : bool = false ## Only true after timer is up

func change_scene(path:String) -> void:
	SceneManager.change_scene(
		path,
		
	)
