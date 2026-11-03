class_name Manage_Levels extends Node
static var ref: Manage_Levels
func _init() -> void:
	ref = self

var _current_level: LEVELS = LEVELS.NONE
enum LEVELS {
	NONE,OVER_1,LOC_1
	}
	
enum _LEVEL_CONTENT {
	SCENE, # PackedScene
	}
	
var _level_data: Dictionary[LEVELS,Dictionary] = {
	LEVELS.NONE:{},
	LEVELS.OVER_1:{
		_LEVEL_CONTENT.SCENE: preload("uid://cw74gl6esrrrw")
	},
	LEVELS.LOC_1:{
		_LEVEL_CONTENT.SCENE: preload("uid://cw74gl6esrrrw")},
}
	
func load_level(which:LEVELS) -> void:
	var scene: Node3D = \
		_level_data[which][
			_LEVEL_CONTENT.SCENE].instantiate()
	Level_Container.ref.add_child(scene)
			
				
