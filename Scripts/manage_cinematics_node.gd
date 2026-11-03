class_name Manage_Cinematics extends Node
static var ref: Manage_Cinematics
func _init() -> void:
	ref = self

const _DEFAULT_LENGTH: float = 4.
var _overall_length: float = _DEFAULT_LENGTH

@onready var _canvas_layer: CanvasLayer = %Cinematic_CanvasLayer
@onready var _timer_overall_length: Timer = %Timer_OverallLength
@onready var _label_texts: Label = %Label_Texts

func _ready() -> void:
	_ready_connections()

func _ready_connections() -> void:
	_timer_overall_length.timeout.connect(_on_length_timeout)

func start() -> void:
	_canvas_layer.visible = true
	_timer_overall_length.start(1)

func _stop() -> void:
	print("stop happened")
	_canvas_layer.visible = false
	_overall_length = _DEFAULT_LENGTH
	Manage_Game.ref.change_game_state(
		Manage_Game.GAME_STATES.WALKING)

func _on_length_timeout() -> void:
	if _overall_length > 0:
		_overall_length -= 1.
		_timer_overall_length.start(1)
		_label_texts.text = "CINEMATIC ENDS IN " + str(_overall_length)
	else:
		_stop()
