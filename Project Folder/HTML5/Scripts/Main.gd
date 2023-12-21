extends Control

func _ready():
	get_viewport().usage = Viewport.USAGE_2D
	get_viewport().disable_3d = true

func Render_toggled(pressed : bool, Tab_ID : int):
	var group : String
	var enviroment_type 
	var designer : bool
	match Tab_ID:
		0:
			group = "3D Tab"
			designer = true
		1:
			group = "2D Tab"
			designer = true
			shader_scale(!pressed)
		2:
			group = "Form Tab"
			designer = false
			shader_scale(pressed)
	
	for i in get_tree().get_nodes_in_group("Designer Tab"):
		i.visible = designer
	
	for i in get_tree().get_nodes_in_group(group):
		i.visible = pressed


func shader_scale(state : bool):
	var scale = lerp(0.5, 10.0, float(state))
	DetailManager.neoprene_shader.set_shader_param("scale", scale)
	DetailManager.leather_shader.set_shader_param("scale", scale)
