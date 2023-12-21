extends WindowDialog

onready var File_name_box = get_node('VBoxContainer/VBoxContainer/HBoxContainer/File Name Box')
onready var Final_render = get_node('VBoxContainer/HBoxContainer/VBoxContainer2/Final Render')

var file_name = "Exported Form"
var export_rect = Vector2(600, 400)
var export_pos = Vector2(100, 100)

func _ready():
	Final_render.set_texture(Final_render.get_child(0).get_texture())

class ReverseAlphabeticalSorter:
	static func sort_descending(a, b):
		if a[0].to_lower() > b[0].to_lower():
			return true
		return false

var first_time : bool = true
func _popup():
	if first_time:
		first_time = false
		export_rect = get_viewport_rect().size * 0.75
		export_pos = (get_viewport_rect().size - (get_viewport_rect().size * 0.75)) * 0.5
	popup(Rect2(export_pos.x,export_pos.y,export_rect.x,export_rect.y))
	get_tree().get_nodes_in_group('Form')[0].export_dialog = true
	
	for i in Final_render.get_child(0).get_children():
		i.queue_free()
	for i in get_tree().get_nodes_in_group('Form')[0].get_child(0).get_children():
		if !(i is Camera2D) and i.visible:
			var new_node = i.duplicate(8)
			Final_render.get_child(0).add_child(new_node)

func _on_Colour_toggled(colour_enabled):
	for shader in [DetailManager.neoprene_shader, DetailManager.leather_shader, DetailManager.snaps_shader]:
		shader.set_shader_param("export", !colour_enabled)

func _on_Export_Dialog_popup_hide():
	if get_tree().get_nodes_in_group('Form') != []:
		get_tree().get_nodes_in_group('Form')[0].export_dialog = false
		_on_Colour_toggled(true)
		export_pos = rect_position
		export_rect = rect_size

func _on_Cancel_pressed():
	hide()

func _on_Save_pressed():
	var image_to_save = Final_render.texture.get_data()
	image_to_save.flip_y()
	if OS.get_name() == "HTML5":
		if File_name_box.text == "":
			JavaScript.download_buffer(image_to_save.save_png_to_buffer(), file_name + ".png", "image/png")
		else:
			JavaScript.download_buffer(image_to_save.save_png_to_buffer(), File_name_box.text + ".png", "image/png")
	hide()
