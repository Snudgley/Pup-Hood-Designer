extends Button

export var catagory = ""
export var button_index : int

func _ready():
	connect('toggled', self, "_button_toggled")

func _button_toggled(button_pressed):
	if button_pressed:
		DetailManager.option_changed(catagory, button_index, button_pressed)
