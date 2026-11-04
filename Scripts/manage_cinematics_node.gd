class_name Manage_Cinematics extends Manage_Levels
static var ref: Manage_Cinematics
func _init() -> void:
	ref = self

enum CINEMATICS {NONE,CINEMATIC_1,CINEMATIC_2}
var _current: CINEMATICS = CINEMATICS.NONE

var _data: Dictionary[CINEMATICS,Dictionary] = {
	CINEMATICS.NONE:{},
	CINEMATICS.CINEMATIC_1:{
		Manage_Levels.LEVEL_CONTENT.SCENE: preload("uid://bnt4tq6t4bjse")
	},
	CINEMATICS.CINEMATIC_2:{
		Manage_Levels.LEVEL_CONTENT.SCENE: preload("uid://bnt4tq6t4bjse")
	},
}

func _my_type() -> _LEVEL_TYPES:
	return _LEVEL_TYPES.CINEMATIC

func switch(to:CINEMATICS) -> void:
	_load_level(
		_data[to][LEVEL_CONTENT.SCENE])
		
func get_current() -> CINEMATICS:
	return _current

func set_current(to:CINEMATICS) -> void:
	_current = to
