extends Cinematic_DramaSubtitlePan

@onready var _alarm_spotlight: SpotLight3D = %Alarm_SpotLight3D
@onready var _alarm_timer: Timer = %Alarm_Timer

const _ALARM_ON_LENGTH: float = 1.
const _ALARM_OFF_LENGTH: float = 1.4

var _alarm_on: bool = false

func _ready_instance() -> void:
	_alarm_timer.timeout.connect(_on_alarm_timeout)
	_alarm_timer.start(_ALARM_ON_LENGTH)

func _my_length() -> float:
	return 14.

func _my_top_subtitle_text() -> String:
	return "And for a time,"
func _my_bottom_subtitle_text() -> String:
	return "the chatbots seemed harmless..."

func _on_cinematic_end() -> void:
	Manage_Walking.ref.change_state(
		Manage_Walking.STATES.OVERWORLD)
		
func _on_alarm_timeout() -> void:
	if _alarm_on: #Alarm is off
		_alarm_spotlight.visible = false
		_alarm_timer.start(_ALARM_ON_LENGTH)
		_alarm_on = false
	else: #Alarm is on
		_alarm_spotlight.visible = true
		_alarm_timer.start(_ALARM_OFF_LENGTH)
		_alarm_on = true
