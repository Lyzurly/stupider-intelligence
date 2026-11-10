class_name Manage_Camera extends Node
static var ref: Manage_Camera
func _init() -> void:
	ref = self

enum CAMERAS {NONE,WALKING,BATTLE}
var _current: CAMERAS = CAMERAS.NONE

func switch(to: CAMERAS) -> void:
	if _current == to:
		return

	_current = to
	print("Camera switched to ",CAMERAS.find_key(_current))
	
	match to:
		CAMERAS.WALKING:
			Camera_Walking.ref.current = true
		CAMERAS.BATTLE:
			Camera_Battle.ref.current = true
