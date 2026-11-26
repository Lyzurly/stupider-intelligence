extends Cinematic_DramaSubtitlePan

func _ready_instance() -> void:
	pass
	
func _my_length() -> float:
	return 14.

func _my_top_subtitle_text() -> String:
	return "For thousands of years, humans have"
func _my_bottom_subtitle_text() -> String:
	return "driven their own destiny..."

func _on_cinematic_end() -> void:
	Manage_Cinematics.ref.switch(
		Manage_Cinematics.CINEMATICS.CINEMATIC_2)
