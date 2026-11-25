extends Cinematic_DramaSubtitlePan

func _my_length() -> float:
	return 14.

func _my_top_subtitle_text() -> String:
	return "With technological advances,"
func _my_bottom_subtitle_text() -> String:
	return "came great cities..."

func _on_cinematic_end() -> void:
	Manage_Walking.ref.change_state(
		Manage_Walking.STATES.OVERWORLD)
