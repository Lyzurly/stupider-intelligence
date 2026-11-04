class_name Manage_Underworld extends Manage_Levels
static var ref: Manage_Underworld
func _init() -> void:
	ref = self

enum UNDERWORLDS {NONE,UNDERWORLD_1,UNDERWORLD_2}
var _current: UNDERWORLDS = UNDERWORLDS.NONE

var _data: Dictionary[UNDERWORLDS,Dictionary] = {
	UNDERWORLDS.NONE:{},
	UNDERWORLDS.UNDERWORLD_1:{
		Manage_Levels.LEVEL_CONTENT.SCENE: preload("uid://cw74gl6esrrrw")
	},
	UNDERWORLDS.UNDERWORLD_2:{
		Manage_Levels.LEVEL_CONTENT.SCENE: preload("uid://cw74gl6esrrrw")
	},
}

func _my_type() -> _LEVEL_TYPES:
	return _LEVEL_TYPES.UNDERWORLD
	
func switch(to:UNDERWORLDS) -> void:
	_load_level(
		_data[to][LEVEL_CONTENT.SCENE])

func get_current() -> UNDERWORLDS:
	return _current

func set_current(to:UNDERWORLDS) -> void:
	_current = to
