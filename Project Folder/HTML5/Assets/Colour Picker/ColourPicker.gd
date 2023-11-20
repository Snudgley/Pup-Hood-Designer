extends Popup

onready var Hue_Box = get_node('PanelContainer/HBoxContainer/Hue Box')
onready var Value_Saturation_Box = get_node('PanelContainer/HBoxContainer/Value Saturation Box')

var hue_mouse_dragging : bool
onready var hue_picker = get_node('PanelContainer/HBoxContainer/Hue Box/Picker')

var value_saturation_mouse_dragging : bool
onready var value_saturation_picker = get_node('PanelContainer/HBoxContainer/Value Saturation Box/Picker')


signal Value_Saturation_Changed
signal Hue_changed

func set_colour():
	print("setting colour")
	value_saturation_picker.rect_position = Vector2(
		clamp((Value_Saturation_Box.rect_size.x - value_saturation_picker.rect_size.x) * DetailManager.body_colour.v, 0, Value_Saturation_Box.rect_size.x - value_saturation_picker.rect_size.x),
		clamp((Value_Saturation_Box.rect_size.y - value_saturation_picker.rect_size.y) * DetailManager.body_colour.s, 0, Value_Saturation_Box.rect_size.y - value_saturation_picker.rect_size.y)
		)
	hue_picker.rect_position = Vector2(
		0,
		clamp((Hue_Box.rect_size.y - hue_picker.rect_size.y) * DetailManager.body_colour.h, 0, Hue_Box.rect_size.y - hue_picker.rect_size.y)
		)
	get_parent().hue = DetailManager.body_colour.h



func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_ENTER:
			if !event.pressed:
				hide()
	
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and !event.pressed and hue_mouse_dragging:
		hue_mouse_dragging = false
	elif event is InputEventMouseMotion and hue_mouse_dragging:
		_move_hue_picker()
	
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and !event.pressed and value_saturation_mouse_dragging:
		value_saturation_mouse_dragging = false
	elif event is InputEventMouseMotion and value_saturation_mouse_dragging:
		_move_Value_Saturation_picker()


func _on_Hue_Box_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		hue_mouse_dragging = true
		_move_hue_picker()

func _move_hue_picker():
	var picker_pos = Hue_Box.get_local_mouse_position().y - (hue_picker.rect_size.y * 0.5)
	hue_picker.rect_position = Vector2(
		0,
		clamp(picker_pos, 0, Hue_Box.rect_size.y - hue_picker.rect_size.y)
		)
	printt(Hue_Box.rect_size.y, hue_picker.rect_size.y)
	var max_rect_y_size = Hue_Box.rect_size.y - hue_picker.rect_size.y
	var Hue = hue_picker.rect_position.y / max_rect_y_size
	Value_Saturation_Box.material.set_shader_param("hue", Hue)
	emit_signal('Hue_changed', Hue)


func _on_Value_Saturation_Box_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		value_saturation_mouse_dragging = true
		_move_Value_Saturation_picker()

func _move_Value_Saturation_picker():
	var picker_pos = Value_Saturation_Box.get_local_mouse_position() - (value_saturation_picker.rect_size * 0.5)
	value_saturation_picker.rect_position = Vector2(
		clamp(picker_pos.x, 0, Value_Saturation_Box.rect_size.x - value_saturation_picker.rect_size.x),
		clamp(picker_pos.y, 0, Value_Saturation_Box.rect_size.y - value_saturation_picker.rect_size.y)
		)
	
	var max_rect_size = rect_size - value_saturation_picker.rect_size
	var Value_Saturation_Range = Vector2(value_saturation_picker.rect_position.x / max_rect_size.x, 1 - value_saturation_picker.rect_position.y / max_rect_size.y)
	emit_signal('Value_Saturation_Changed', Value_Saturation_Range)
