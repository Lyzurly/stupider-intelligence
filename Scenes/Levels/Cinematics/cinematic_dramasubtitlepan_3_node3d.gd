extends Cinematic_DramaSubtitlePan

func _my_length() -> float:
	return 60000.

func _my_top_subtitle_text() -> String:
	return "Society flourished"
func _my_bottom_subtitle_text() -> String:
	return "through hard work and determination..."

func _on_cinematic_end() -> void:
	Manage_Walking.ref.change_state(
		Manage_Walking.STATES.OVERWORLD)
