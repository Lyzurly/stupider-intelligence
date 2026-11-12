@abstract class_name Battle_Maze_Template extends TileMapLayer

@abstract func _my_type() -> Manage_BattleMaze.TEMPLATES

const _POS_BASE: Vector2 = Vector2(-192.,-1536.)
const _POS_T2_INWARD: Vector2 = Vector2(-192.,-2400)
const _POS_T2_OUTWARD: Vector2 = Vector2(-192.,-576)
const _POS_T2_UNIQUE: Vector2 = Vector2(-192.,-1440)

var _current_seg_inward: TileMapLayer
var _current_seg_outward: TileMapLayer
var _current_seg_unique: TileMapLayer
@onready var _template_t1: Battle_Maze_Template = %BattleMazeTemplate_T1_TileMapLayer
@onready var _template_t2: Battle_Maze_Template = %BattleMazeTemplate_T2_TileMapLayer

func _ready() -> void:
	
	_ready_segments()

func _ready_segments() -> void:
	var inward_scene: PackedScene = \
		Manage_BattleMaze.ref.get_inward_segment()
	_current_seg_inward = inward_scene.instantiate() as TileMapLayer

	var outward_scene: PackedScene = \
		Manage_BattleMaze.ref.get_outward_segment()
	_current_seg_outward = outward_scene.instantiate() as TileMapLayer
		
	var unique_scene: PackedScene = \
		Manage_BattleMaze.ref.get_unique_segment()
	_current_seg_unique = unique_scene.instantiate() as TileMapLayer
		
	
	match Manage_BattleMaze.ref.get_current_template_type():
		Manage_BattleMaze.TEMPLATES.T1:
			_template_t2.queue_free()
		Manage_BattleMaze.TEMPLATES.T2:
			_template_t1.queue_free()
	
	add_child(_current_seg_inward)
	add_child(_current_seg_outward)
	add_child(_current_seg_unique)
	
	_place_segments()
	
func _place_segments() -> void:
	var pos_inward: Vector2
	var pos_outward: Vector2
	var pos_unique: Vector2
	
	match _my_type():
		Manage_BattleMaze.TEMPLATES.T1:
			pos_inward = _POS_BASE
			pos_outward = _POS_BASE
			pos_unique = _POS_BASE
		Manage_BattleMaze.TEMPLATES.T2:
			pos_inward = _POS_T2_INWARD
			pos_outward = _POS_T2_OUTWARD
			pos_unique = _POS_T2_UNIQUE
		
	_current_seg_inward.global_position = pos_inward
	_current_seg_outward.global_position = pos_outward
	_current_seg_unique.global_position = pos_unique
