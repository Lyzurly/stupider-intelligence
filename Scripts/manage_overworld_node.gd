class_name Manage_Overworld extends Manage_World
static var ref: Manage_Overworld
func _init() -> void:
	ref = self

enum OVERWORLDS {NONE,OW1,OW2}
var _current: OVERWORLDS = OVERWORLDS.NONE

var _data: Dictionary[OVERWORLDS,Dictionary] = {
	OVERWORLDS.NONE:{},
	OVERWORLDS.OW1:{
		Manage_Level.LEVEL_CONTENT.SCENE: preload("uid://cw74gl6esrrrw"),
		Manage_Level.LEVEL_CONTENT.ENVIRONMENT: preload("uid://c2ifkl0ktxr37")
	},
	OVERWORLDS.OW2:{
		Manage_Level.LEVEL_CONTENT.SCENE: preload("uid://cw74gl6esrrrw"),
		Manage_Level.LEVEL_CONTENT.ENVIRONMENT: preload("uid://c2ifkl0ktxr37")
	},
}

func _my_type() -> LEVEL_TYPES:
	return LEVEL_TYPES.OVERWORLD

func switch(to:OVERWORLDS) -> void:
	_load_level(
		_data[to][LEVEL_CONTENT.SCENE],
		_data[to][LEVEL_CONTENT.ENVIRONMENT]
	)
	
func get_current() -> OVERWORLDS:
	return _current
	
func set_current(to:OVERWORLDS) -> void:
	_current = to
