extends WindowDialog

onready var File_tree = get_node('VBoxContainer/HBoxContainer/VBoxContainer/Tree')
onready var Path_display = get_node("VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer2/Directory Path")
onready var File_name_box = get_node('VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/File Name Box')
onready var Final_render = get_node('VBoxContainer/HBoxContainer/VBoxContainer2/Final Render')

var path = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
const folder_icon = preload('res://Textures/Folder.svg')
const image_icon = preload('res://Textures/Image.svg')
const test_icon = preload('res://Textures/Circle.png')

var file_name = "Exported Form"
var export_rect = Vector2(600, 400)
var export_pos = Vector2(100, 100)

func _ready():
	create_file_tree()
	Final_render.set_texture(Final_render.get_child(0).get_texture())

class ReverseAlphabeticalSorter:
	static func sort_descending(a, b):
		if a[0].to_lower() > b[0].to_lower():
			return true
		return false

func create_file_tree():
	var folders = []
	var images = []
	Path_display.text = path
	File_tree.clear()
	File_tree.create_item()
	File_tree.set_hide_root(true)
	
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		while file_name != "":
			
			
			if dir.current_is_dir():
				folders.append(file_name)
			elif file_name.ends_with(".png"):
				images.append(file_name)
			
			file_name = dir.get_next()
			
	else:
		print("An error occurred when trying to access the path.")
	
	folders.sort_custom(ReverseAlphabeticalSorter, "sort_descending")
	images.sort_custom(ReverseAlphabeticalSorter, "sort_descending")
	
	var folders_and_images = [images, folders, image_icon, folder_icon]
	for i in 2:
		for ii in folders_and_images[i]:
			var item = File_tree.create_item(null, 0)
			item.set_text(0, ii)
			item.set_icon(0, folders_and_images[i + 2])
	if path.length() > 3:
		var exit_folder = File_tree.create_item(null, 0)
		exit_folder.set_text(0, "..")
		exit_folder.set_icon(0, folder_icon)

func _on_Tree_item_activated():
	if File_tree.get_selected().get_text(0).to_lower().ends_with(".png"):
		_on_Save_pressed()
	else:
		if File_tree.get_selected().get_text(0) == "..":
			path = path.left(path.find_last("/") + (1 * int(path.left(path.find_last("/")).length() < 3)))
			
			create_file_tree()
		else:
			if path.right(path.length() - 1) != "/":
				path = path + "/"
			path = path + File_tree.get_selected().get_text(0)
			create_file_tree()

func _on_Tree_item_selected():
	var selected_text = File_tree.get_selected().get_text(0)
	if selected_text.to_lower().ends_with(".png"):
		File_name_box.text = selected_text.left(selected_text.length() - 4)

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
	DetailManager.neoprene_shader.set_shader_param("export", !colour_enabled)
	DetailManager.leather_shader.set_shader_param("export", !colour_enabled)
	DetailManager.snaps_shader.set_shader_param("export", !colour_enabled)

func _on_Export_Dialog_popup_hide():
	if get_tree().get_nodes_in_group('Form') != []:
		get_tree().get_nodes_in_group('Form')[0].export_dialog = false
		_on_Colour_toggled(true)
		export_pos = rect_position
		export_rect = rect_size

func _on_Directory_Path_text_entered(new_path : String):
	if new_path.length() > 3:
		new_path = new_path.replace("\\", "/")
	var dir = Directory.new()
	if dir.open(new_path) == OK:
		path = new_path
		create_file_tree()

func _on_Cancel_pressed():
	hide()

func _on_Save_pressed():
	var image_to_save = Final_render.texture.get_data()
	image_to_save.flip_y()
	if File_name_box.text == "":
		image_to_save.save_png(path + "/" + file_name + ".png")
	else:
		image_to_save.save_png(path + "/" + File_name_box.text + ".png")
	hide()
