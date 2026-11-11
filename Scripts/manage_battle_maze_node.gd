class_name Manage_BattleMaze extends Node
static var ref: Manage_BattleMaze
func _init() -> void:
	ref = self
	
var _current_maze: TileMapLayer
	
func get_new_maze() -> TileMapLayer:
	#create the maze and assign to _current_maze
	return _current_maze
