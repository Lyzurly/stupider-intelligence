class_name Manage_Overworld extends Manage_Levels
static var ref: Manage_Overworld
func _init() -> void:
	ref = self

enum OVERWORLDS {NONE,OVERWORLD_1,OVERWORLD_2}
var _current: OVERWORLDS = OVERWORLDS.NONE

var _data: Dictionary[OVERWORLDS,Dictionary] = {
	OVERWORLDS.NONE:{},
	OVERWORLDS.OVERWORLD_1:{
		Manage_Levels.LEVEL_CONTENT.SCENE: preload("uid://cw74gl6esrrrw")
	},
	OVERWORLDS.OVERWORLD_2:{
		Manage_Levels.LEVEL_CONTENT.SCENE: preload("uid://cw74gl6esrrrw")
	},
}

func _my_type() -> _LEVEL_TYPES:
	return _LEVEL_TYPES.OVERWORLD

func switch(to:OVERWORLDS) -> void:
	_load_level(
		_data[to][LEVEL_CONTENT.SCENE])
	
		
func get_current() -> OVERWORLDS:
	return _current
	
func set_current(to:OVERWORLDS) -> void:
	_current = to
