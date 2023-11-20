extends Control

func _on_Interactive_ordering_form_toggled(a):
	for i in get_tree().get_nodes_in_group("Form Tab"):
		i.visible = a

func _on_Full_Hood_Render_toggled(a):
	for i in get_tree().get_nodes_in_group("Designer Tab"):
		i.visible = a
