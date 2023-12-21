extends Popup

var node_group : String
var is_leather : bool

onready var Lists_container = get_node('Panel/ScrollContainer/Lists Container')
onready var Leather_list = Lists_container.get_node('Leather')
onready var Neoprene_list = Lists_container.get_node('Neoprene')

func _popup(new_node_group : String, new_is_leather : bool):
	node_group = new_node_group
	is_leather = new_is_leather
	popup()
	var list_rect_size : Vector2
	match is_leather:
		true:
			Leather_list.visible = true
			list_rect_size = Leather_list.rect_size
		false:
			Neoprene_list.visible = true
			list_rect_size = Neoprene_list.rect_size
	
	get_child(0).rect_size.x = 140
	rect_size = Vector2(140, clamp(list_rect_size.y + 20, 80, get_viewport().size.y))
	rect_position = Vector2(
			clamp(get_global_mouse_position().x - (rect_size.x * 0.5), 0, get_viewport().size.x - rect_size.x),
			clamp(get_global_mouse_position().y, 0, get_viewport().size.y - rect_size.y)
			)
	yield(get_tree(), 'idle_frame')
	rect_size = Vector2(140, clamp(list_rect_size.y + 20, 80, get_viewport().size.y))
	get_child(0).rect_size = rect_size
	for i in get_tree().get_nodes_in_group("Mouse Ignore on Popup"):
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _colour_selected(index):
	hide()
	Leather_list.visible = false
	Neoprene_list.visible = false
	match is_leather:
		true:
			DetailManager._change_colour(HoodCodeManager.leather_colours[index], node_group)
		false:
			DetailManager._change_colour(HoodCodeManager.neoprene_colours[index], node_group)
	_popup_hide()

func _popup_hide():
	for i in get_tree().get_nodes_in_group("Mouse Ignore on Popup"):
		i.mouse_filter = Control.MOUSE_FILTER_STOP
