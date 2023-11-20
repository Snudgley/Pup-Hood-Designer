extends Viewport

var hood_selector : bool
var export_dialog : bool

export var Menu_bar_path : NodePath
onready var Menu_bar = get_node(Menu_bar_path)
func _physics_process(delta):
	if hood_selector or export_dialog:
		get_tree().get_nodes_in_group('Form')[0].gui_disable_input = true
	else:
		get_tree().get_nodes_in_group('Form')[0].gui_disable_input = get_viewport().get_mouse_position().y < Menu_bar.rect_size.y
