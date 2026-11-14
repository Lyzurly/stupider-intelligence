class_name Manage_MenuBehavior extends Node
static var ref: Manage_MenuBehavior
func _init() -> void:
	ref = self
	
## To add new rows:
## Duplicate the generic menurow scene. Style it as desired.
## Add and name a new ROW_SCENE enum, and create a corresponding entry in the other places here that make sense.
## Copy the UID of the new menurow scene you made, and add it to the PackedScene constant.
## Wherever the menu is created (via the create_new_menu function), just add the new ROW_SCENES enum as the row to instantiate.

enum ROW_SCENES {
	NONE,
	GENERIC,
	NEW_OR_LOAD_GAME,
	CREATE_CLASS_TITLE,
	CREATE_CLASS_ROW1,
	CREATE_CLASS_ROW2,
	CREATE_CLASS_SUBMIT,
	}

const _ROW_SCENE_GENERIC: PackedScene = preload("uid://g61yy80letg6")
const _ROW_SCENE_NEW_OR_LOAD_GAME: PackedScene = preload("uid://dl2uv1stbq2ss")
const _ROW_SCENE_CREATE_CLASS_TITLE: PackedScene = preload("uid://cdkpycrb43jjr")
const _ROW_SCENE_CREATE_CLASS_ROW1: PackedScene = preload("uid://datdbl873yss3")
const _ROW_SCENE_CREATE_CLASS_ROW2: PackedScene = preload("uid://bgoigumxme0pk")
const _ROW_SCENE_CREATE_CLASS_SUBMIT: PackedScene = preload("uid://bc65ipkw17pjw")
	
@onready var _canvas_layer: CanvasLayer = %Menus_CanvasLayer

@onready var _row1_container: PanelContainer = %Row1_PanelContainer
@onready var _row2_container: PanelContainer = %Row2_PanelContainer
@onready var _row3_container: PanelContainer = %Row3_PanelContainer
@onready var _row4_container: PanelContainer = %Row4_PanelContainer

var _row_scene_data: Dictionary[ROW_SCENES,PackedScene] = {
	ROW_SCENES.NONE: null,
	ROW_SCENES.GENERIC: _ROW_SCENE_GENERIC,
	ROW_SCENES.NEW_OR_LOAD_GAME: _ROW_SCENE_NEW_OR_LOAD_GAME,
	ROW_SCENES.CREATE_CLASS_TITLE: _ROW_SCENE_CREATE_CLASS_TITLE,
	ROW_SCENES.CREATE_CLASS_ROW1: _ROW_SCENE_CREATE_CLASS_ROW1,
	ROW_SCENES.CREATE_CLASS_ROW2: _ROW_SCENE_CREATE_CLASS_ROW2,
	ROW_SCENES.CREATE_CLASS_SUBMIT: _ROW_SCENE_CREATE_CLASS_SUBMIT,
	}

var _current_row_nodes: Array[Control] = []

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause"):
		Manage_Menus.ref.change_state(
			Manage_Menus.STATES.PAUSE)

func create_new_menu(
row1:ROW_SCENES=ROW_SCENES.NONE,
row2:ROW_SCENES=ROW_SCENES.NONE,
row3:ROW_SCENES=ROW_SCENES.NONE,
row4:ROW_SCENES=ROW_SCENES.NONE,
) -> void:
	for row_node in _current_row_nodes:
		row_node.queue_free()
	
	if not row1 == ROW_SCENES.NONE:
		var row1_node: Control = \
			_row_scene_data[row1].instantiate()
		_row1_container.add_child(row1_node)
		_current_row_nodes.append(row1_node)
	
	if not row2 == ROW_SCENES.NONE:
		var row2_node: Control = \
			_row_scene_data[row2].instantiate()
		_row2_container.add_child(row2_node)
		_current_row_nodes.append(row2_node)
	
	if not row3 == ROW_SCENES.NONE:
		var row3_node: Control = \
			_row_scene_data[row3].instantiate()
		_row3_container.add_child(row3_node)
		_current_row_nodes.append(row3_node)
	
	if not row4 == ROW_SCENES.NONE:
		var row4_node: Control = \
			_row_scene_data[row4].instantiate()
		_row4_container.add_child(row4_node)
		_current_row_nodes.append(row4_node)

func show_if_needed() -> void:
	if not _canvas_layer.visible:
		_canvas_layer.visible = true
func hide_if_needed() -> void:
	if _canvas_layer.visible:
		_canvas_layer.visible = false
