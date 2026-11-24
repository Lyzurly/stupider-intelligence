@abstract class_name Battle_Maze_Container extends Node2D

enum WHO_CONTROLS {NONE,PLAYER,OPPONENT}

@abstract func _ready_instance() -> void
@abstract func get_who_controls_me() -> WHO_CONTROLS 

func _ready() -> void:
	_ready_instance()
