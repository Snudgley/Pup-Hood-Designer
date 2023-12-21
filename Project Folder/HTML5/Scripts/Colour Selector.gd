extends Button

export var node_group : String

func _on_Button_pressed():
	DetailManager.colours_popup._popup(node_group, HoodCodeManager.settings[0] == 5)
