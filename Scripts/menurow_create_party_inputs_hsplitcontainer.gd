@abstract class_name MenuRow_CreateParty_Inputs extends Control


@abstract func _name1_textbox() -> LineEdit
@abstract func _name2_textbox() -> LineEdit

@abstract func _class1_dropdown() -> OptionButton
@abstract func _class2_dropdown() -> OptionButton

@abstract func _on_name1_changed(to:String) -> void
		
@abstract func _on_name2_changed(to:String) -> void

@abstract func _on_class1_chosen(id:int) -> void

@abstract func _on_class2_chosen(id:int) -> void

func _ready() -> void:
	_ready_class_lists()
	_ready_connections()

func _ready_connections() -> void:
	_name1_textbox().text_changed.connect(_on_name1_changed)
	_name1_textbox().text_changed.connect(_on_any_input_used)
	
	_name2_textbox().text_changed.connect(_on_name2_changed)
	_name2_textbox().text_changed.connect(_on_any_input_used)
	
	_class1_dropdown().item_selected.connect(_on_class1_chosen)
	_class1_dropdown().item_selected.connect(_on_any_input_used)
	
	_class2_dropdown().item_selected.connect(_on_class2_chosen)
	_class2_dropdown().item_selected.connect(_on_any_input_used)
	
func _ready_class_lists() -> void:
	for class_string: String in \
	Manage_Party.CLASSES.keys():
		var string_to_add: String = class_string
		string_to_add = \
			string_to_add.replace("_"," ")
		
		if class_string == "NONE":
			string_to_add = "Choose class..."
			
		_class1_dropdown().add_item(string_to_add)
		_class2_dropdown().add_item(string_to_add)
		
	
func _on_any_input_used(_doesnt_matter:Variant) -> void:
	Manage_MenuBehavior.ref.a_create_party_property_was_set.emit()
