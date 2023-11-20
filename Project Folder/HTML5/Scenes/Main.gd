extends Control

func _on_Interactive_ordering_form_toggled(pressed : bool):
	for i in get_tree().get_nodes_in_group("Form Tab"):
		i.visible = pressed
	shader_scale(pressed)

func _on_Full_Hood_Render_toggled(pressed : bool):
	for i in get_tree().get_nodes_in_group("Designer Tab"):
		i.visible = pressed
	shader_scale(!pressed)

func shader_scale(state : bool):
	var scale = lerp(0.5, 10.0, float(state))
	DetailManager.neoprene_shader.set_shader_param("scale", scale)
	DetailManager.leather_shader.set_shader_param("scale", scale)
