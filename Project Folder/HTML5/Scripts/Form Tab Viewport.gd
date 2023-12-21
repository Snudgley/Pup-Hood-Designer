extends Viewport

var hood_selector : bool
var export_dialog : bool

func _physics_process(delta):
	match hood_selector or export_dialog:
		true:
			get_tree().get_nodes_in_group('Form')[0].gui_disable_input = true
		false:
			get_tree().get_nodes_in_group('Form')[0].gui_disable_input = get_viewport().get_mouse_position().y < 0
	
