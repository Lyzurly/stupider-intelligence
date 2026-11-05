class_name Level_Container extends Node3D
static var ref: Level_Container
func _init() -> void:
	ref = self

#region "Camera" rotation ======================
const ROT_MIN: float = -45.
const ROT_MAX: float = 315
var rot_amount: float = 0. # dir represented by lerp b/n -1 to 1
#endregion -------------------------------------

func _input(event: InputEvent) -> void:
	_input_rotation(event)

func show_if_needed() -> void:
	if not visible:
		visible = true

func _input_rotation(event:InputEvent) -> void:
	if Input.is_action_just_pressed("Clockwise"):
			rot_amount = 1.
	elif Input.is_action_just_pressed("CounterClockwise"):
			rot_amount = -1.
	else:
		return
	
	var clamprot: float = clamp(
			global_rotation.y + rot_amount,
			ROT_MIN,ROT_MAX)
	
	if clamprot < ROT_MIN:
		clamprot = ROT_MAX
	elif clamprot > ROT_MAX:
		clamprot = ROT_MIN 

	global_rotation.y = lerp(
		global_rotation.y,clamprot,.6)	
		
	Camera.ref.set_lerp_speed(1.)
		

	
