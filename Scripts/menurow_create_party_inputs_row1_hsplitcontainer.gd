class_name MenuRow_CreateParty_Inputs_Row1 extends MenuRow_CreateParty_Inputs

func _name1_textbox() -> LineEdit:
	return $CreateChar_Row_HSplitContainer/MenuBox_Title/PanelContainer/MarginContainer/VBoxContainer/CharName1_LineEdit
func _name2_textbox() -> LineEdit:
	return $CreateChar_Row_HSplitContainer/MenuBox_Info/PanelContainer/MarginContainer/VBoxContainer/CharName2_LineEdit

func _class1_dropdown() -> OptionButton:
	return $CreateChar_Row_HSplitContainer/MenuBox_Title/PanelContainer/MarginContainer/VBoxContainer/Class1_OptionButton
func _class2_dropdown() -> OptionButton:
	return $CreateChar_Row_HSplitContainer/MenuBox_Info/PanelContainer/MarginContainer/VBoxContainer/Class2_OptionButton

func _on_name1_changed(to:String) -> void:
	Manage_Party.ref.set_party_data_content(
		Manage_Party.CHARACTERS.CHARACTER1,
		Manage_Party.PARTY_CONTENT.NAME,
		to)
		
func _on_name2_changed(to:String) -> void:
	Manage_Party.ref.set_party_data_content(
		Manage_Party.CHARACTERS.CHARACTER2,
		Manage_Party.PARTY_CONTENT.NAME,
		to)

func _on_class1_chosen(id:int) -> void:
	Manage_Party.ref.set_party_data_content(
		Manage_Party.CHARACTERS.CHARACTER1,
		Manage_Party.PARTY_CONTENT.CLASS,
		Manage_Party.ref.get_class_from_int(id)
		)

func _on_class2_chosen(id:int) -> void:
	Manage_Party.ref.set_party_data_content(
		Manage_Party.CHARACTERS.CHARACTER2,
		Manage_Party.PARTY_CONTENT.CLASS,
		Manage_Party.ref.get_class_from_int(id)
		)
