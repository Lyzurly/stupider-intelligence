class_name Camera extends Node3D
static var ref: Camera
func _init() -> void:
	ref = self

const OFFSET_POS: Vector3 = Vector3(15.6,13.3,15.66)	

func _physics_process(_delta: float) -> void:
	_physics_process_follow_player()

func _physics_process_follow_player() -> void:
	if not is_instance_valid(Player.ref):
		return
	var player_pos: Vector3 = \
		Player.ref.global_position
	var target_pos: Vector3 = \
		player_pos + OFFSET_POS
				
	global_position = global_position.lerp(target_pos,.1)
	
