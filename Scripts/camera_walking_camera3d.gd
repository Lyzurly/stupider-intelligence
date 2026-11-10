class_name Camera_Walking extends Camera3D
static var ref: Camera_Walking
func _init() -> void:
	ref = self

const _OFFSET_POS: Vector3 = Vector3(-.23,34.,58.)	
#const _DEFAULT_LERP_SPEED: float = .001
const _DEFAULT_LERP_SPEED: float = 1.
const _LOW_LERP_SPEED: float = .1
var _lerp_speed: float = _DEFAULT_LERP_SPEED

func _physics_process(_delta: float) -> void:
	_physics_process_follow_player()

func _physics_process_follow_player() -> void:
	if not is_instance_valid(Player.ref):
		return
	var player_pos: Vector3 = \
		Player.ref.global_position
	var target_pos: Vector3 = \
		player_pos + _OFFSET_POS
				
	global_position = global_position.lerp(target_pos,_lerp_speed)

func get_default_lerp_speed() -> float:
	return _DEFAULT_LERP_SPEED
func get_low_lerp_speed() -> float:
	return _LOW_LERP_SPEED

func set_lerp_speed(to:float) -> void:	
	_lerp_speed = to
	
func lower_lerp_speed() -> void:
	_lerp_speed = lerp(_lerp_speed,_LOW_LERP_SPEED,_LOW_LERP_SPEED)

func reset_lerp_speed() -> void:
	_lerp_speed = lerp(_lerp_speed,_DEFAULT_LERP_SPEED,.00001)
	#_lerp_speed = _DEFAULT_LERP_SPEED
	
