class_name Manage_Input extends Node
static var ref: Manage_Input
func _init() -> void:
	ref = self
	
var _input_dir: Vector2

#region "Camera" rotation ======================
const _ROT_MIN: float = -45.
const _ROT_MAX: float = 315
var _rot_amount: float = 0. # dir represented by lerp b/n -1 to 1
#endregion -------------------------------------

	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Clockwise") \
	or Input.is_action_just_pressed("CounterClockwise"):
		_set_new_level_rotation()
	
func _is_walking_overworld_underworld() -> bool:
	return \
	Manage_Walking.ref.is_state(
	Manage_Walking.STATES.OVERWORLD) \
	or Manage_Walking.ref.is_state(
	Manage_Walking.STATES.UNDERWORLD)

#region Walking Over/Underworld inputs ==============
func walk(input_dir:Vector2) -> void:
	if not _is_walking_overworld_underworld():
		return
	_input_dir = input_dir
func get_managed_input_dir() -> Vector2:
	return _input_dir

func _set_new_level_rotation() -> void:
	var clamprot: float = 0.
	if not _is_walking_overworld_underworld():
		return
		
	if Input.is_action_just_pressed("Clockwise"):
			_rot_amount = 1.
	elif Input.is_action_just_pressed("CounterClockwise"):
			_rot_amount = -1.
	else:
		return
	
	clamprot = clamp(
			Level_Container.ref.get_level_rotation().y \
									+ _rot_amount,
			_ROT_MIN,_ROT_MAX)
	
	if clamprot < _ROT_MIN:
		clamprot = _ROT_MAX
	elif clamprot > _ROT_MAX:
		clamprot = _ROT_MIN 
	
	Level_Container.ref.input_rotation(clamprot)
#endregion --------------------------------------------
