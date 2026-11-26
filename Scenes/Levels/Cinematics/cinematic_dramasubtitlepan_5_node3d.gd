extends Cinematic_DramaSubtitlePan

func _ready_instance() -> void:
	pass
	
func _my_length() -> float:
	return 60000.

func _my_top_subtitle_text() -> String:
	return "But now... They threaten everything"
func _my_bottom_subtitle_text() -> String:
	return "that we have accomplished..."

func _on_cinematic_end() -> void:
	Manage_Walking.ref.change_state(
		Manage_Walking.STATES.OVERWORLD)
