class_name Manage_BattleScene extends Manage_Level
static var ref: Manage_BattleScene
func _init() -> void:
	ref = self

enum BATTLE_SCENES {NONE,BATTLE_1,BATTLE_2}
var _current: BATTLE_SCENES = BATTLE_SCENES.NONE

var _data: Dictionary[BATTLE_SCENES,Dictionary] = {
	BATTLE_SCENES.NONE:{},
	BATTLE_SCENES.BATTLE_1:{
		Manage_Level.LEVEL_CONTENT.SCENE: preload("uid://d2672tsns0pfy")
	},
	BATTLE_SCENES.BATTLE_2:{
		Manage_Level.LEVEL_CONTENT.SCENE: preload("uid://cw74gl6esrrrw")
	},
}

func _my_type() -> LEVEL_TYPES:
	return LEVEL_TYPES.BATTLE_SCENE

func switch(to:BATTLE_SCENES) -> void:
	_load_level(
		_data[to][LEVEL_CONTENT.SCENE])
	
	
func get_current() -> BATTLE_SCENES:
	return _current
	
func set_current(to:BATTLE_SCENES) -> void:
	_current = to
