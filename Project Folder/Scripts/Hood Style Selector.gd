extends Button

const Hood_styles = ["Neoprene Frisky Hood", "Neoprene K9 Hood", "Neoprene Puppy Hood", "Neoprene Woof Hood", "Neoprene Muzzle", "Leather K9 Hood"]
export var node_group : String
onready var popup = get_child(0)

func _ready():
	DetailManager.hood_type_change_node = self

func _on_MenuButton_toggled(button_pressed):
	if button_pressed:
		popup.popup()
		get_tree().get_nodes_in_group('Form')[0].hood_selector = true
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
		HoodCodeManager._settings_to_code()

func _hood_style_selected(index):
	popup.hide()
	for i in Hood_styles:
		for ii in get_tree().get_nodes_in_group(i):
			ii.hide()
	for i in get_tree().get_nodes_in_group(Hood_styles[index]):
		i.show()
	HoodCodeManager.settings[HoodCodeManager.node_groups.find("Hood Type")] = index
	HoodCodeManager._settings_to_code()
	Price._set_price()

func _on_Popup_visibility_changed():
	if get_tree().get_nodes_in_group('Form') != []:
		get_tree().get_nodes_in_group('Form')[0].hood_selector = false
	if !popup.visible:
		yield(get_tree().create_timer(.5), 'timeout')
		set_pressed(false)
