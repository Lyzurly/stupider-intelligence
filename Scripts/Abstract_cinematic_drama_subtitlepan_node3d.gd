@abstract class_name Cinematic_DramaSubtitlePan extends Cinematic

const _DEFAULT_LENGTH: float = 4.
const _BEGINNING_OF_END_DESCALAR: float = .45
const _BLACKOUT_START_DESCALAR: float = .3

const _SUBTITLE_OFFSET_OFFSET: float = 400
const _SUBTITLE_FADE_IN_SPEED: float = 2.

const _BLACKOUT_FADE_SPEED: float = 4.

var _overall_length: float = _DEFAULT_LENGTH
var _beginning_of_end_length: float = _DEFAULT_LENGTH * .45
var _beginning_of_end_time: float
var _blackout_start_time: float

@onready var _canvas_layer: CanvasLayer = %Cinematic_CanvasLayer
@onready var _timer_overall_length: Timer = %Timer_OverallLength
@onready var _timer_beginning_of_end: Timer = %Timer_BeginningOfEnd
@onready var _timer_blackout_start: Timer = %Timer_BlackoutStart
@onready var _subtitle_top: Label = %Label_Subtitle_Top
@onready var _subtitle_bottom: Label = %Label_Subtitle_Bottom
@onready var _blackout_texture: TextureRect = %Blackout_TextureRect

@abstract func _my_length() -> float
@abstract func _my_top_subtitle_text() -> String
@abstract func _my_bottom_subtitle_text() -> String
@abstract func _on_cinematic_end() -> void
@abstract func _ready_instance() -> void

func _ready() -> void:
	_ready_connections()
	_ready_subtitles()
	_ready_timers()
	_ready_instance()

func _ready_connections() -> void:
	_timer_overall_length.timeout.connect(_on_length_timeout)
	_timer_beginning_of_end.timeout.connect(_on_beginning_of_end_timeout)
	_timer_blackout_start.timeout.connect(_on_blackout_start_timeout)

func _ready_subtitles() -> void:
	_subtitle_top.modulate.a = 0.
	_subtitle_bottom.modulate.a = 0.
	
func _ready_timers() -> void:
	_overall_length = _my_length()
	
	_beginning_of_end_length = _my_length() * _BEGINNING_OF_END_DESCALAR
	_beginning_of_end_time = _overall_length - _beginning_of_end_length
	
	var blackout_start_length = _my_length() * _BLACKOUT_START_DESCALAR
	_blackout_start_time = _overall_length - blackout_start_length

func start() -> void:
	Camera_Cinematic.ref.dramatic_pan(false)
	_blackout_visibility(false)
	_canvas_layer.visible = true
	_dramatic_subtitle_movement()
	_subtitle_visibility(true)
	Camera_Cinematic.ref.dramatic_pan(true,_overall_length)
	_subtitle_top.text = _my_top_subtitle_text()
	_subtitle_bottom.text = _my_bottom_subtitle_text()
	_timer_overall_length.start(1)
	_timer_beginning_of_end.start(_beginning_of_end_time)
	_timer_blackout_start.start(_blackout_start_time)

func _blackout_visibility(indeed:bool) -> void:
	var target_alpha: float = 1. if indeed else 0.
	var tween_ease: Tween.EaseType = \
		 Tween.EaseType.EASE_OUT if indeed else Tween.EaseType.EASE_IN
	
	var tween: Tween = create_tween()
	tween.tween_property(
		_blackout_texture,
		"modulate:a",
		target_alpha,
		_BLACKOUT_FADE_SPEED
		).set_ease(tween_ease)
	
func _subtitle_visibility(indeed:bool) -> void:
	var target_alpha: float = 1. if indeed else 0.
	var fade_speed: float = \
		_SUBTITLE_FADE_IN_SPEED if indeed else _beginning_of_end_length
	var tween_ease: Tween.EaseType = \
		 Tween.EaseType.EASE_OUT if indeed else Tween.EaseType.EASE_IN
	
	var tween: Tween = create_tween()
	tween.parallel().tween_property(
		_subtitle_top,
		"modulate:a",
		target_alpha,
		fade_speed
		).set_ease(tween_ease)
	tween.parallel().tween_property(
		_subtitle_bottom,
		"modulate:a",
		target_alpha,
		fade_speed
		).set_ease(tween_ease)
	
func _dramatic_subtitle_movement() -> void:
	var top_offset: float = _subtitle_top.offset_transform_position.x
	var bottom_offset: float = _subtitle_bottom.offset_transform_position.x
	
	var tween: Tween = create_tween()
	tween.parallel().tween_property(
		_subtitle_top,
		"offset_transform_position",
		Vector2(
			top_offset + _SUBTITLE_OFFSET_OFFSET,0.),
		_overall_length + _overall_length/3
		)
	tween.parallel().tween_property(
		_subtitle_bottom,
		"offset_transform_position",
		Vector2(
			bottom_offset + -_SUBTITLE_OFFSET_OFFSET,0.),
		_overall_length
		)


func _stop() -> void:
	print("A cinematic stopped!")
	_timer_overall_length.stop()
	_canvas_layer.visible = false
	Camera_Cinematic.ref.dramatic_pan(false)
	_overall_length = _DEFAULT_LENGTH
	_on_cinematic_end()
	
func _on_length_timeout() -> void:
	if _overall_length > 0:
		_overall_length -= 1.
		_timer_overall_length.start(1)
	else:
		_stop()
		
func _on_beginning_of_end_timeout() -> void:
	_subtitle_visibility(false)

func _on_blackout_start_timeout() -> void:
	_blackout_visibility(true)
