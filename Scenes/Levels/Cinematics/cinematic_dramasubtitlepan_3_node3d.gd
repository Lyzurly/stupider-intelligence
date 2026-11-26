extends Cinematic_DramaSubtitlePan

func _ready_instance() -> void:
	pass
	
func _my_length() -> float:
	return 14.

func _my_top_subtitle_text() -> String:
	return "Society flourished through hard work"
func _my_bottom_subtitle_text() -> String:
	return "and determination..."

func _on_cinematic_end() -> void:
	Manage_Cinematics.ref.switch(
		Manage_Cinematics.CINEMATICS.CINEMATIC_4)
