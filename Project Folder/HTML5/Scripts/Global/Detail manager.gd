extends Node

const textures = {
	"Red" : [
		0,
		0
		],
	"Orange" : [
		1,
		1
		],
	"Golden" : [
		2,
		2
		],
	"Yellow" : [
		2,
		3
		],
	"Lime" : [
		3,
		4
		],
	"Hunter" : [
		4,
		5
		],
	"Aqua" : [
		5,
		6
		],
	"Baby Blue" : [
		5,
		6
		],
	"Cobalt" : [
		6,
		7
		],
	"Turquoise" : [
		6,
		7
		],
	"Royal" : [
		7,
		8
		],
	"Med Blue" : [
		7,
		8
		],
	"Navy" : [
		8,
		9
		],
	"DK Blue" : [
		8,
		9
		],
	"Purple" : [
		9,
		10
		],
	"Pink" : [
		10,
		11
		],
	"Hot Pink" : [
		10,
		11
		],
	"Pink " : [
		11,
		12
		],
	"White" : [
		11,
		13
		],
	"Grey" : [
		12,
		14
		],
	"Matte" : [
		13,
		15
		],
	"Black" : [
		13,
		15
		],
	"Shiny" : [
		14,
		15
		],
	"DK Brown" : [
		13,
		16
		],
	"Textured" : [
		15,
		15
		],
	"Camo" : [
		16,
		5
		],
	"Brown" : [
		17,
		17
		],
	"Tan" : [
		17,
		18
		]
	}

const names = {
	"Red" : [
		"Red",
		"Red"
		],
	"Orange" : [
		'Orange',
		'Orange'
		],
	"Golden" : [
		'Yellow',
		'Golden'
		],
	"Yellow" : [
		'Yellow',
		'Yellow'
		],
	"Lime" : [
		'Lime',
		'Lime'
		],
	"Hunter" : [
		'Hunter',
		'Hunter'
		],
	"Aqua" : [
		'Aqua',
		'Baby Blue'
		],
	"Baby Blue" : [
		'Aqua',
		'Baby Blue'
		],
	"Cobalt" : [
		'Cobalt',
		'Turquoise'
		],
	"Turquoise" : [
		'Cobalt',
		'Turquoise'
		],
	"Royal" : [
		'Royal',
		'Med Blue'
		],
	"Med Blue" : [
		'Royal',
		'Med Blue'
		],
	"Navy" : [
		'Navy',
		'DK Blue'
		],
	"DK Blue" : [
		'Navy',
		'DK Blue'
		],
	"Purple" : [
		'Purple',
		'Purple'
		],
	"Pink" : [
		'Pink',
		'Hot Pink'
		],
	"Hot Pink" : [
		'Pink',
		'Hot Pink'
		],
	"Pink " : [
		'White',
		'Pink'
		],
	"White" : [
		'White',
		'White'
		],
	"Grey" : [
		'Grey',
		'Grey'
		],
	"Matte" : [
		'Matte',
		'Black'
		],
	"Black" : [
		'Matte',
		'Black'
		],
	"Shiny" : [
		"Shiny",
		"Black"
		],
	"DK Brown" : [
		'Matte',
		'DK Brown'
		],
	"Textured" : [
		'Textured',
		'Black'
		],
	"Camo" : [
		'Camo',
		'Hunter'
		],
	"Brown" : [
		'Brown',
		'Brown'
		],
	"Tan" : [
		'Brown',
		'Tan'
		]
	}

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

const neoprene_shader : ShaderMaterial = preload('res://Materials/Decrypt Image Neoprene GLES2.material')
const leather_shader : ShaderMaterial = preload('res://Materials/Decrypt Image Leather GLES2.material')
const mesh_neoprene_shader : ShaderMaterial = preload('res://Materials/3D Material Neoprene.material')
const mesh_leather_shader : ShaderMaterial = preload('res://Materials/3D Material Leather.material')

const snaps_shader : ShaderMaterial = preload('res://Materials/Decrypt Image Snaps GLES2.material')
const mesh_snaps_shader : ShaderMaterial = preload('res://Materials/3D Snaps.material')
const snaps_groups = [
	"face_snaps",
	"back_eyelets",
	"muzzle_eyelets"
	]

var body_colour : Vector3 = Vector3(0,0,1)
const body_shader : ShaderMaterial = preload('res://Materials/Decrypt Image Base.material')
const mesh_body_shader : ShaderMaterial = preload('res://Materials/3D Base.material')

onready var colours_popup = get_tree().get_nodes_in_group("Colours Popup")[0]
onready var colour_picker = get_tree().get_nodes_in_group("Colour Picker")[0]

var hood_type_change_node : Button
func _hood_type_change(index):
	hood_type_change_node._hood_style_selected(index)

func _change_colour(index, node_group):
	_settings_changed(node_group, names.keys().find(index))
	
	match node_group:
		"CrownNeck", "Base":
			if index == "Shiny":
				for i in get_tree().get_nodes_in_group('1_2 Selection'):
					i.text = "Shiny"
				change_colour_base_crownneck(index)
			else:
				var a = false
				var t = ""
				for i in get_tree().get_nodes_in_group('1_2 Selection'):
					if i.text == "Shiny":
						a = true
					else:
						t = i.text
				if a:
					for i in get_tree().get_nodes_in_group('1_2 Selection'):
						i.text = t
					change_colour_base_crownneck(index)
				else:
					change_texture(index, node_group)
					global_update_selection_text(index, node_group)
						
		_:
			change_texture(index, node_group)
			global_update_selection_text(index, node_group)

func change_colour_base_crownneck(index):
	for i in ["CrownNeck", "Base"]:
		change_texture(index, i)
		global_update_selection_text(index, i)
		_settings_changed(i, names.keys().find(index))

func change_texture(index, node_group):
	node_group = node_group.replacen(" ", "_").to_lower()
	for n_shader in [neoprene_shader, mesh_neoprene_shader]:
		n_shader.set_shader_param(node_group, textures[index][0])
	for l_shader in [leather_shader, mesh_leather_shader]:
		l_shader.set_shader_param(node_group, textures[index][1])

func change_snaps_texture(index, node_group):
	for s_shader in [snaps_shader, mesh_snaps_shader]:
		s_shader.set_shader_param(node_group.replacen(" ", "_").to_lower(), index)

func global_update_selection_text(index, node_group):
	for i in get_tree().get_nodes_in_group(node_group):
		if i.is_in_group("Colour Selection Button"):
			i.text = names[index][1] if i.is_in_group("Leather") else names[index][0]

const muzzle_length = ["Muzzle Short", "Muzzle Standard", "Muzzle Long"]

const hood_options = [
	"Black", "Silver", "Brass", 
	"Single", "Double", 
	"Standard", "Floppy", "Pointed", 
	"Short", "Standard", "Long", 
	"Yes", "No",
	"7 Holes", "Eyelets", "Whiskers", "Fur", "4 Holes"
	]

var accepting_changes = false
var wait_for_change = false
func option_changed(catagory : String, index : int, pressed : bool):
	if !accepting_changes:
		yield(self, 'ready')
		accepting_changes = true
		return
	if !wait_for_change:
		wait_for_change = true
		change_hood(catagory, index, pressed)
		change_buttons(catagory, index, pressed)
		wait_for_change = false
		if catagory == "Eyeglass Slots" or catagory == "Ear Holes" or catagory == "Jowl":
			_settings_changed(catagory, pressed)
		else:
			_settings_changed(catagory, index)

var snap_node_groups = [
	"Snaps",
	"Lacing Eyelets",
	"Muzzle Eyelets"
	]
var muzzle_types = ["Frisky", "K9", "Puppy"]

func change_hood(catagory : String, index : int, pressed : bool):
	for i in get_tree().get_nodes_in_group("Preview"):
		match catagory:
			"Eyeglass Slots":
				if i.is_in_group(catagory):
					i.visible = pressed
				if i.is_in_group("3D Hood"):
					i.set("blend_shapes/Eye Glass Slots", float(pressed))
			"Ear Holes":
				if i.is_in_group(catagory):
					i.visible = pressed
				if i.is_in_group("3D Hood"):
					i.set("blend_shapes/Ear Holes", float(pressed))
			"Jowl":
				if i.is_in_group(catagory):
					i.visible = pressed
				if i.is_in_group("Adjust For Jowl"):
					i.set("blend_shapes/Jowl", float(pressed))
			"Brow Style":
				if i.is_in_group("Brow Style"):
					if i.is_in_group("Brow Double"):
						i.visible = index != 0
					elif i.is_in_group("Brow Single"):
						i.visible = index == 0
				elif i.is_in_group("3D Adjust For Brow"):
					i.set("blend_shapes/Brow Double", float(index != 0))
			"Muzzle Length":
				if i.is_in_group("3D Muzzle"):
					i.set("blend_shapes/Long", float(index == 2))
					i.set("blend_shapes/Short", float(index == 0))
				elif i.is_in_group("Muzzle Base"):
					if !i.is_in_group("Puppy"):
						if pressed:
							if index == 0 and i.is_in_group("Leather"):
								if i.is_in_group("Muzzle " + hood_options[9]):
									i.visible = true
								else:
									i.visible = false
							elif i.is_in_group("Muzzle " + hood_options[index + 8]):
								i.visible = true
							else:
								i.visible = false
			"Muzzle Detail B":
				if !i.is_in_group("Hood Option Button"):
					if i.is_in_group("Muzzle Detail B"):
						if i.is_in_group("Leather") and (index == 0 or index == 4):
							if i.is_in_group(hood_options[14]):
								i.visible = true
							else:
								i.visible = false
						elif i.is_in_group("Frisky") and index != 1:
								if i.is_in_group(hood_options[17]):
									i.visible = true
								else:
									i.visible = false
						elif i.is_in_group(hood_options[index + 13] if index < 4 else hood_options[13]):
							i.visible = true
						else:
							i.visible = false
						
			"Ear Style":
				if i.is_in_group("Ear"):
					if (i.is_in_group("Leather") and index != 1) or !i.is_in_group("Leather"):
						if i.is_in_group(hood_options[index + 5] + " Ear"):
							i.visible = true
						else:
							i.visible = false
			"Muzzle Type":
				if i.is_in_group("Muzzle Preview"):
					i.visible = i.is_in_group(muzzle_types[index] + " Muzzle")
			
			_:
				if snap_node_groups.find(catagory) != -1:
					if i.is_in_group("SnapsEyelets"):
						change_snaps_texture(index, snaps_groups[snap_node_groups.find(catagory)])

var snap_colours = ["Snap Black", "Snap Silver", "Snap Brass"]
func change_buttons(catagory : String, index : int, pressed : bool):
	match catagory:
		"Jowl":
			for i in get_tree().get_nodes_in_group("Jowl Colour"):
				i.disabled = !pressed
		"Muzzle Detail B":
			for i in get_tree().get_nodes_in_group("Muzzle Detail B Colour"):
				i.disabled = index < 2
	for i in get_tree().get_nodes_in_group("Hood Option Button"):
		if i.is_in_group("Preview"):
			if i.node_group == catagory:
				match catagory:
					"Eyeglass Slots", "Ear Holes", "Jowl":
						i.text = "Yes" if pressed else "No"
					"Brow Style":
						i.text = "Single" if index == 0 else "Double"
					"Muzzle Length":
						if (i.is_in_group("Leather") and index == 0):
							i.text = hood_options[9]
						else:
							i.text = hood_options[index + 8]
					"Muzzle Detail B":
						if i.is_in_group("Leather") :
							if (index == 0 or index == 4): 
								i.text = hood_options[14]
								for ii in get_tree().get_nodes_in_group('Muzzle Eyelets'):
									ii.show()
								for ii in get_tree().get_nodes_in_group('Muzzle Detail B Colour'):
									if ii.is_in_group('Leather') and ii.is_in_group('Colour Selection Button'):
										ii.hide()
							else:
								i.text = hood_options[13 + index]
								for ii in get_tree().get_nodes_in_group('Muzzle Eyelets'):
										ii.visible = index == 1
								for ii in get_tree().get_nodes_in_group('Muzzle Detail B Colour'):
									if ii.is_in_group('Leather') and ii.is_in_group('Colour Selection Button'):
										ii.visible = index != 1
						elif (i.is_in_group("Frisky") and index != 1):
							i.text = hood_options[17]
						else:
							i.text = hood_options[index + 13] if index < 4 else hood_options[13]
						
					"Ear Style":
						if (i.is_in_group("Leather") and index != 1) or !i.is_in_group("Leather"):
							i.text = hood_options[index + 5]
					"Muzzle Type":
						if i.is_in_group("Muzzle Type Button"):
							i.text = muzzle_types[index]
							for ii in get_tree().get_nodes_in_group("Muzzle Options"):
								ii.visible = ii.is_in_group(muzzle_types[index] + " Options")
					_:
						if snap_node_groups.find(catagory) != -1:
							if i.is_in_group(catagory):
								i.text = hood_options[index]
		else:
			if i.catagory == catagory:
				if i.button_index == index:
					i.pressed = pressed
				match catagory:
					"Muzzle Length":
						if (i.is_in_group("Leather") and index == 0) and i.button_index == 1:
							i.pressed = true
					"Muzzle Detail B":
						if i.is_in_group("Frisky"):
							if i.is_in_group("4 Holes"):
								i.visible = index == 1
						else:
							if index == 4:
								if i.button_index == 0:
									i.pressed = true

func _settings_changed(catagory : String, index : int):
	if !HoodCodeManager.neoprene_colour_groups.has(catagory):
		HoodCodeManager.settings[HoodCodeManager.node_groups.find(catagory)] = index
	else: 
		HoodCodeManager.settings[HoodCodeManager.node_groups.find(catagory)] = HoodCodeManager.neoprene_colours.find(names.keys()[index])
	Price._set_price()
