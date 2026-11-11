class_name Manage_BattleScene extends Manage_Level
static var ref: Manage_BattleScene
func _init() -> void:
	ref = self

var _current_scene: PackedScene
func _my_type() -> LEVEL_TYPES:
	return LEVEL_TYPES.BATTLE_SCENE

func switch() -> void:
	var current: PackedScene = \
		get_new_battle()
	_load_level(
		current,
		Manage_Environment.ref.get_current_scene()
	)
	_set_current_scene(current)

func get_current_scene() -> PackedScene:
	return _current_scene

func _set_current_scene(to:PackedScene) -> void:
	_current_scene = to
