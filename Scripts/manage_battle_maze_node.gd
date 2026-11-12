class_name Manage_BattleMaze extends Node
static var ref: Manage_BattleMaze
func _init() -> void:
	ref = self

enum TEMPLATES {NONE,T1,T2}
var _current_template: TEMPLATES = TEMPLATES.NONE
var _current_maze_node: Battle_Maze
var _current_template_tilemaplayer: Battle_Maze_Template

const _SEGMENTS_INWARD: Array[PackedScene] = [
	preload("uid://c4r2foa8yuto1"),
	]
const _SEGMENTS_OUTWARD: Array[PackedScene] = [
	preload("uid://0h7k3is1apkq")
	]
const _SEGMENTS_T1_UNIQUE: Array[PackedScene] = [
	preload("uid://c8njoybbabm3s")
	]
const _SEGMENTS_T2_UNIQUE: Array[PackedScene] = [
	preload("uid://boh6pfy6igv8f")
	]
	
var seg_inward_node: TileMapLayer
var seg_outward_node: TileMapLayer
var seg_unique_node: TileMapLayer
	
var _battles: Array[Battle_Maze_Template] = []

func on_battle_started(from:Battle_Maze_Template) -> void:
	_battles.append(from)
	
func generate_mazes() -> void:
	while not _battles.size() == 2:
		pass
	
	_pick_template()
	_pick_segments()
	_place_segments()

func _pick_template() -> void:
	var gen_t1: bool = \
		true if randf_range(-1.,1) > 0 else false

	if gen_t1:
		_current_template = TEMPLATES.T1
	else:
		_current_template = TEMPLATES.T2

func _pick_segments() -> void:
	var seg_inwards: Array[PackedScene] = \
		_SEGMENTS_INWARD.duplicate()
	seg_inwards.shuffle()
	seg_inward_node = \
		seg_inwards.pop_front().instantiate() as TileMapLayer
	
	var seg_outwards: Array[PackedScene] = \
		_SEGMENTS_OUTWARD.duplicate()
	seg_outwards.shuffle()
	seg_outward_node = \
		seg_outwards.pop_front().instantiate() as TileMapLayer
	
	var seg_unique: Array[PackedScene] = \
		_SEGMENTS_T1_UNIQUE.duplicate() \
			if _current_template == TEMPLATES.T1 \
			else \
		_SEGMENTS_T2_UNIQUE.duplicate()
	seg_unique.shuffle()
	seg_unique_node = \
		seg_unique.pop_front().instantiate() as TileMapLayer
	
func _place_segments() -> void:
	for battle in _battles:
		battle.add_segments(
			seg_inward_node,
			seg_outward_node,
			seg_unique_node
		)
