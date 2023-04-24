extends TextureRect

const node_groups = [
	"Base", 
	"CrownNeck", 
	"Brow", 
	"Bridge", 
	"Nose",
	"Muzzle", 
	"Lip",
	"Chin", 
	"Inner Chin",
	"Tongue",
	"Ear C",
	"Ear A", 
	"Ear B", 
	"Jowl Colour", 
	"Muzzle Detail B Colour"
	]

var pos_map_image : Image
onready var Neo_hood_colour_popup = get_node('Neoprene Hood Colour Popup')
onready var Lea_hood_colour_popup = get_node('Leather Hood Colour Popup')
onready var body_colour_popup = get_node('ColorPicker')

var node_group : int
const alpha_threshold = 0.2

const body_shader : ShaderMaterial = preload('res://Materials/Decrypt Image Base.material')
export var is_leather : bool

func _ready():
	pos_map_image = texture.get_data()
	pos_map_image.lock()

func _on_TextureRect_gui_input(event):
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
	if pos_map_image.get_pixel(mouse_pixel_pos.x, mouse_pixel_pos.y).a > alpha_threshold:
		accept_event()
		if pos_map_image.get_pixel(mouse_pixel_pos.x, mouse_pixel_pos.y).v < 0.2:
			_body_colour_popup()
		else:
			node_group = round(pos_map_image.get_pixel(mouse_pixel_pos.x, mouse_pixel_pos.y).h * 15)
			_hood_colour_popup()
	else:
		_pass_to_next(event)

func _pass_to_next(event):
	if focus_next != "":
		get_node(focus_next)._on_TextureRect_gui_input(event)

func _body_colour_popup():
	body_colour_popup.popup()
	body_colour_popup.rect_size = body_colour_popup.get_child(0).rect_size
	
	body_colour_popup.rect_position = Vector2(
		clamp(get_viewport().get_mouse_position().x - (body_colour_popup.rect_size.x * 0.5), 0, get_viewport().size.x - body_colour_popup.rect_size.x),
		clamp(get_viewport().get_mouse_position().y, 0, get_viewport().size.y - body_colour_popup.rect_size.y)
		)
	body_colour_popup.set_colour()

func _hood_colour_popup():
	var hood_colour_popup = Lea_hood_colour_popup if is_leather else Neo_hood_colour_popup
	hood_colour_popup.popup()
	hood_colour_popup.rect_size = hood_colour_popup.get_child(0).rect_size
	if get_viewport().is_in_group("Form"):
		hood_colour_popup.rect_position = Vector2(
			clamp(get_global_mouse_position().x - (hood_colour_popup.rect_size.x * 0.5), 0, 4400 - hood_colour_popup.rect_size.x),
			clamp(get_global_mouse_position().y, 0, 3400 - hood_colour_popup.rect_size.y)
			)
	else:
		hood_colour_popup.rect_position = Vector2(
			clamp(get_viewport().get_mouse_position().x - (hood_colour_popup.rect_size.x * 0.5), 0, get_viewport().size.x - hood_colour_popup.rect_size.x),
			clamp(get_viewport().get_mouse_position().y, 0, get_viewport().size.y - hood_colour_popup.rect_size.y)
			)

func _hood_colour_selected(index):
	if is_leather:
		Lea_hood_colour_popup.hide()
		DetailManager._change_colour(HoodCodeManager.leather_colours[index], node_groups[node_group])
	else:
		Neo_hood_colour_popup.hide()
		DetailManager._change_colour(HoodCodeManager.neoprene_colours[index], node_groups[node_group])

var hue : float

func _Value_Saturation_Changed(new_Value_Saturation):
	var new_colour = body_shader.get_shader_param('base')
	new_colour.v = new_Value_Saturation.y
	new_colour.s = new_Value_Saturation.x
	new_colour.h = hue
	body_shader.set_shader_param('base', new_colour)
	DetailManager.body_colour = new_colour

func _Hue_changed(new_Hue):
	hue = new_Hue
	var new_colour = body_shader.get_shader_param('base')
	new_colour.h = new_Hue
	body_shader.set_shader_param('base', new_colour)
	DetailManager.body_colour.h = hue
