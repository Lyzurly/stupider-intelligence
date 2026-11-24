class_name Programmed_Arrow extends Node2D

var _is_placed: bool = false

func place_me() -> void:
	_is_placed = true

func _physics_process(_delta: float) -> void:
	_physics_process_placing()
	
	
func _physics_process_placing() -> void:
	if _is_placed:
		return
		
	var mouse_pos: Vector2 = \
		get_global_mouse_position()
		
	global_position = mouse_pos 
