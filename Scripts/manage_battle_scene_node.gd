class_name Manage_BattleScene extends Manage_Level
static var ref: Manage_BattleScene
func _init() -> void:
	ref = self

const _BATTLE_CONTAINER_SCENE: PackedScene = preload("uid://d2672tsns0pfy")
const _BATTLE_MAZE_CANVASLAYER_SCENE: PackedScene = preload("uid://bdbb2t05dc1t0")
const _BATTLE_MENU_CANVASLAYER_SCENE: PackedScene = preload("uid://dhswb6bqy7pko")

var _current_scene: PackedScene
func _my_type() -> LEVEL_TYPES:
	return LEVEL_TYPES.BATTLE_SCENE

func switch() -> void:
	var current: PackedScene = \
		_BATTLE_CONTAINER_SCENE
	var enviro: PackedScene = \
		Manage_Environment.ref.get_current_scene()
	
	_load_level(
		current,
		enviro
	)
	
	_set_current_scene(current)
	
	var menu_canvaslayer: CanvasLayer = \
		_BATTLE_MENU_CANVASLAYER_SCENE.instantiate()
	add_child(menu_canvaslayer)

func get_current_scene() -> PackedScene:
	return _current_scene

func load_maze_canvaslayer() -> void:
	Manage_BattleMaze.ref.generate_mazes()
	var maze_canvaslayer: CanvasLayer = \
		_BATTLE_MAZE_CANVASLAYER_SCENE.instantiate()
	add_child(maze_canvaslayer)

func _set_current_scene(to:PackedScene) -> void:
	_current_scene = to
