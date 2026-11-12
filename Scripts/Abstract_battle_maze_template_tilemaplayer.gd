@abstract class_name Battle_Maze_Template extends TileMapLayer

@abstract func _my_type() -> Manage_BattleMaze.TEMPLATES

const _POS_BASE: Vector2 = Vector2(-192.,-1536.)
const _POS_T2_INWARD: Vector2 = Vector2(-192.,-2400)
const _POS_T2_OUTWARD: Vector2 = Vector2(-192.,-580)
const _POS_T2_UNIQUE: Vector2 = Vector2(-192.,-1440)

var _current_seg_inward: TileMapLayer
var _current_seg_outward: TileMapLayer
var _current_seg_unique: TileMapLayer

func _ready() -> void:
	Manage_BattleMaze.ref.on_battle_started(self)

func add_segments(
inward:TileMapLayer,
outward:TileMapLayer,
unique:TileMapLayer
) -> void:
	_current_seg_inward = inward
	_current_seg_outward = outward
	_current_seg_unique = unique
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
