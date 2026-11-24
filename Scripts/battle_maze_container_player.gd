class_name Battle_Maze_Container_Player extends Battle_Maze_Container


func _ready_instance() -> void:
	_ready_connections()

func _ready_connections() -> void:
	Manage_Ability_ProgramPath.ref.programming.connect(
		_on_programming)
	
func get_who_controls_me() -> WHO_CONTROLS:
	return WHO_CONTROLS.PLAYER

func _on_programming(arrow:Programmed_Arrow) -> void:
	add_child(arrow)
