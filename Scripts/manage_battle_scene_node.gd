class_name Manage_BattleScene extends Manage_Level
static var ref: Manage_BattleScene
func _init() -> void:
	ref = self

signal mazes_generated

@warning_ignore_start("unused_signal")
signal a_nav_poly_ready(nav_poly:Polygon2D)
@warning_ignore_restore("unused_signal")

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
		Manage_Instantiation.ref.instantiate_something(
			_BATTLE_MENU_CANVASLAYER_SCENE,
			Manage_Instantiation.INSTANCES.BATTLE_MENU)
	if menu_canvaslayer:
		add_child(menu_canvaslayer)

func get_current_scene() -> PackedScene:
	return _current_scene

func load_maze_canvaslayer() -> void:
	Manage_BattleMaze.ref.generate_mazes()
	var maze_canvaslayer: CanvasLayer = \
		Manage_Instantiation.ref.instantiate_something(
			_BATTLE_MAZE_CANVASLAYER_SCENE)
	add_child(maze_canvaslayer)
	
	await get_tree().process_frame
	mazes_generated.emit()
	

func _set_current_scene(to:PackedScene) -> void:
	_current_scene = to
