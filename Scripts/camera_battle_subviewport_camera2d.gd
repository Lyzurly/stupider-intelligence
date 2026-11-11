class_name Camera_Battle_Subviewport extends Camera2D

const _DEFAULT_LERP_SPEED: float = 1.
const _LOW_LERP_SPEED: float = .01
var _lerp_speed: float = _LOW_LERP_SPEED

@onready var _action_pawn: ActionPawn = %ActionPawn_CharacterBody2D

func _physics_process(_delta: float) -> void:
	_physics_process_follow_pawn()

func _physics_process_follow_pawn() -> void:
	if not is_instance_valid(_action_pawn):
		return
	var pawn_pos: Vector2 = \
		_action_pawn.global_position
		
	global_position.y = lerp(global_position.y,pawn_pos.y,_lerp_speed)
