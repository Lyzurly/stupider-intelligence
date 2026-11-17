class_name Player_MeshContainer extends Node3D

@onready var _mesh: Node3D = %brain_mesh

func get_player_mesh() -> Node3D:
	return _mesh
