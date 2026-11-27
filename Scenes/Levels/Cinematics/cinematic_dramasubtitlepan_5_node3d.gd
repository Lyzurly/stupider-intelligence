extends Cinematic_DramaSubtitlePan

@onready var _bug_animations: AnimationPlayer = %Bug_AnimationPlayer

func _ready_instance() -> void:
	_bug_animations.play("swarm")
	
func _my_length() -> float:
	return 14.

func _my_top_subtitle_text() -> String:
	return "But now, they threaten everything"
func _my_bottom_subtitle_text() -> String:
	return "that we have accomplished..."

func _on_cinematic_end() -> void:
	Manage_Walking.ref.change_state(
		Manage_Walking.STATES.OVERWORLD)
