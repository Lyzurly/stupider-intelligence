class_name Manage_Underworld extends Manage_World
static var ref: Manage_Underworld
func _init() -> void:
	ref = self

enum UNDERWORLDS {
	NONE,OW1_UW1,OW1_UW2
}
var _current: UNDERWORLDS = UNDERWORLDS.NONE

var _data: Dictionary[UNDERWORLDS,Dictionary] = {
	UNDERWORLDS.NONE:{},
	UNDERWORLDS.OW1_UW1:{
		Manage_Level.LEVEL_CONTENT.SCENE: preload("uid://wwln17hfavdv"),
		Manage_Level.LEVEL_CONTENT.ENVIRONMENT: preload("uid://c2ifkl0ktxr37")
	},
	UNDERWORLDS.OW1_UW2:{
		Manage_Level.LEVEL_CONTENT.SCENE: preload("uid://cw74gl6esrrrw"),
		Manage_Level.LEVEL_CONTENT.ENVIRONMENT: preload("uid://c2ifkl0ktxr37")
	},
}

func _my_type() -> LEVEL_TYPES:
	return LEVEL_TYPES.UNDERWORLD
	
func switch(to:UNDERWORLDS) -> void:
	_load_level(
		_data[to][LEVEL_CONTENT.SCENE],
		_data[to][LEVEL_CONTENT.ENVIRONMENT],
	)
	_set_current(to)

func get_current() -> UNDERWORLDS:
	return _current

func _set_current(to:UNDERWORLDS) -> void:
	_current = to
