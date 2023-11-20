extends Button

export var node_group : String
onready var popup = get_child(0)

func _on_Button_pressed():
	popup.popup()
	popup.rect_size = popup.get_child(0).rect_size
	if get_viewport().is_in_group("Form"):
		popup.rect_position = Vector2(
			clamp(get_global_mouse_position().x - (popup.rect_size.x * 0.5), 0, 4400 - popup.rect_size.x),
			clamp(get_global_mouse_position().y, 0, 3400 - popup.rect_size.y)
			)
	else:
		popup.rect_position = Vector2(
			clamp(get_viewport().get_mouse_position().x - (popup.rect_size.x * 0.5), 0, get_viewport().size.x - popup.rect_size.x),
			clamp(get_viewport().get_mouse_position().y, 0, get_viewport().size.y - popup.rect_size.y)
			)

func _option_selected(index):
	popup.hide()
	DetailManager.option_changed("Muzzle Type", index, true)
