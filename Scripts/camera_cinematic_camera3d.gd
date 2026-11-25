class_name Camera_Cinematic extends Camera3D
static var ref: Camera_Cinematic
func _init() -> void:
	ref = self
	
const _H_OFFSET_END: float = 30.
const _H_OFFSET_START: float = 0.

var tween: Tween

func dramatic_pan(
indeed:bool,
pan_speed:float=1.
) -> void:
	if not indeed:
		h_offset = 0.
		return
		
	var target_offset: float = _H_OFFSET_END
		
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self,"h_offset",target_offset,pan_speed)
