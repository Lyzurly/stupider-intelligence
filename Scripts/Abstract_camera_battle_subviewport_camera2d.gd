@abstract class_name Camera_Battle_Subviewport extends Camera2D

@abstract func _my_pawn() -> ActionPawn

const _DEFAULT_LERP_SPEED: float = 1.
const _LOW_LERP_SPEED: float = .1
var _lerp_speed: float = _LOW_LERP_SPEED

func _physics_process(_delta: float) -> void:
	_physics_process_follow_pawn()

func _physics_process_follow_pawn() -> void:
	if not is_instance_valid(_my_pawn()):
		return
	var pawn_pos: Vector2 = \
		_my_pawn().global_position

	global_position = global_position.lerp(pawn_pos,_lerp_speed)
