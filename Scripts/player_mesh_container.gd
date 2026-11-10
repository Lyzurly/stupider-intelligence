class_name Player_MeshContainer extends Node3D

@onready var _mesh: MeshInstance3D = %Player_MeshInstance3D

func get_player_mesh() -> MeshInstance3D:
	return _mesh
