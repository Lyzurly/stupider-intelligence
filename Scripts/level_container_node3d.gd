class_name Level_Container extends Node3D
static var ref: Level_Container
func _init() -> void:
	ref = self

func show_if_needed() -> void:
	if not visible:
		visible = true
