class_name Manage_BattleMaze extends Node
static var ref: Manage_BattleMaze
func _init() -> void:
	ref = self
	
var _current_maze: TileMapLayer

func generate_maze() -> void:
	#create the maze and assign to _current_maze
	pass
	
func get_current_maze() -> TileMapLayer:
	return _current_maze
