extends TextureRect

var pos_map_image : Image

var node_group : int
const alpha_threshold = 0.2

export var is_leather : bool
export var top_layer : bool

func _ready():
	pos_map_image = texture.get_data()
	pos_map_image.lock()

func _input(event):
	if top_layer:
		_process_input(event)

func _process_input(event):
	if !is_visible_in_tree():
		_pass_to_next(event)
	else:
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_RIGHT:
				if event.pressed:
					if get_viewport().is_in_group("Form"):
						var scaling = rect_size.y / texture.get_size().y
						var mouse_pixel_pos = Vector2(
							clamp(get_local_mouse_position().x / scaling, 0, texture.get_size().x - 1),
							clamp(get_local_mouse_position().y / scaling, 0, texture.get_size().y - 1)
							)
						_get_pixel(mouse_pixel_pos, event)
					
					else:
						var x_scaling = rect_size.x / texture.get_size().x
						var y_scaling = rect_size.y / texture.get_size().y
						if x_scaling > y_scaling:
							var scaling = rect_size.y / texture.get_size().y
							var spacing = ((rect_size.x / scaling) - texture.get_size().x) * 0.5
							var mouse_pixel_pos = Vector2(
								clamp(get_local_mouse_position().x / scaling - spacing, 0, texture.get_size().x - 1),
								clamp(get_local_mouse_position().y / scaling, 0, texture.get_size().y - 1)
								)
							_get_pixel(mouse_pixel_pos, event)
						else:
							var scaling = rect_size.x / texture.get_size().x
							var spacing = ((rect_size.y / scaling) - texture.get_size().y) * 0.5
							var mouse_pixel_pos = Vector2(
								clamp(get_local_mouse_position().x / scaling, 0, texture.get_size().x),
								clamp(get_local_mouse_position().y / scaling - spacing, 0, texture.get_size().y)
								)
							_get_pixel(mouse_pixel_pos, event)

func _get_pixel(mouse_pixel_pos, event):
	var pixel_colour = pos_map_image.get_pixel(mouse_pixel_pos.x, mouse_pixel_pos.y)
	match pixel_colour.a > alpha_threshold:
		true:
			match pixel_colour.v < 0.2:
				true:
					_body_colour_popup()
				false:
					node_group = round(pixel_colour.h * 15)
					_hood_colour_popup()
		false:
			_pass_to_next(event)

func _pass_to_next(event):
	if focus_next != "":
		get_node(focus_next)._process_input(event)

func _body_colour_popup():
	DetailManager.colour_picker._popup()

func _hood_colour_popup():
	DetailManager.colours_popup._popup(DetailManager.node_groups[node_group], HoodCodeManager.settings[0] == 5)


