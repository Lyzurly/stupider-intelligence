class_name Manage_Environment extends Node
static var ref: Manage_Environment
func _init() -> void:
	ref = self
	
var _current: Level_Environment
var _current_scene: PackedScene = \
	preload("uid://c2ifkl0ktxr37")

func get_current() -> Level_Environment:
	return _current

func _set_current(to:Level_Environment) -> void:
	_current = to
	
func get_current_scene() -> PackedScene:
	return _current_scene

func set_current_scene(to:PackedScene) -> void:
	_current_scene = to
