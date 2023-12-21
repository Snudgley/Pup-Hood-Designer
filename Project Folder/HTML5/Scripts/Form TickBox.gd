extends Button

export var catagory = ""
export var button_index : int

func _on_Form_TickBox_toggled(button_pressed):
	DetailManager.option_changed(catagory, button_index, button_pressed)
