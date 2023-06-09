extends Node

const neo_red       = preload('res://Textures/Colour Overlays/Neoprene/Red.png')
const neo_orange    = preload('res://Textures/Colour Overlays/Neoprene/Orange.png')
const neo_yellow    = preload('res://Textures/Colour Overlays/Neoprene/Yellow.png')
const neo_lime      = preload('res://Textures/Colour Overlays/Neoprene/Lime.png')
const neo_hunter    = preload('res://Textures/Colour Overlays/Neoprene/Hunter.png')
const neo_aqua      = preload('res://Textures/Colour Overlays/Neoprene/Aqua.png')
const neo_cobalt    = preload('res://Textures/Colour Overlays/Neoprene/Cobalt.png')
const neo_royal     = preload('res://Textures/Colour Overlays/Neoprene/Royal.png')
const neo_navy      = preload('res://Textures/Colour Overlays/Neoprene/Navy.png')
const neo_purple    = preload('res://Textures/Colour Overlays/Neoprene/Purple.png')
const neo_pink      = preload('res://Textures/Colour Overlays/Neoprene/Pink.png')
const neo_white     = preload('res://Textures/Colour Overlays/Neoprene/White.png')
const neo_grey      = preload('res://Textures/Colour Overlays/Neoprene/Grey.png')
const neo_black     = preload('res://Textures/Colour Overlays/Neoprene/Matte.png')
const neo_shiny     = preload('res://Textures/Colour Overlays/Neoprene/Shiny.png')
const neo_textured  = preload('res://Textures/Colour Overlays/Neoprene/Textured.png')
const neo_camo      = preload('res://Textures/Colour Overlays/Neoprene/Camo.png')
const neo_brown     = preload('res://Textures/Colour Overlays/Neoprene/Brown.png')
const lea_red       = preload('res://Textures/Colour Overlays/Leather/Red.png')
const lea_orange    = preload('res://Textures/Colour Overlays/Leather/Orange.png')
const lea_golden    = preload('res://Textures/Colour Overlays/Leather/Golden.png')
const lea_yellow    = preload('res://Textures/Colour Overlays/Leather/Yellow.png')
const lea_lime      = preload('res://Textures/Colour Overlays/Leather/Lime.png')
const lea_hunter    = preload('res://Textures/Colour Overlays/Leather/Hunter.png')
const lea_baby_blue = preload('res://Textures/Colour Overlays/Leather/Baby Blue.png')
const lea_turquoise = preload('res://Textures/Colour Overlays/Leather/Turquoise.png')
const lea_med_blue  = preload('res://Textures/Colour Overlays/Leather/Med Blue.png')
const lea_dk_blue   = preload('res://Textures/Colour Overlays/Leather/DK Blue.png')
const lea_purple    = preload('res://Textures/Colour Overlays/Leather/Purple.png')
const lea_hot_pink  = preload('res://Textures/Colour Overlays/Leather/Hot Pink.png')
const lea_pink      = preload('res://Textures/Colour Overlays/Leather/Pink.png')
const lea_white     = preload('res://Textures/Colour Overlays/Leather/White.png')
const lea_grey      = preload('res://Textures/Colour Overlays/Leather/Grey.png')
const lea_black     = preload('res://Textures/Colour Overlays/Leather/Black.png')
const lea_dk_brown  = preload('res://Textures/Colour Overlays/Leather/DK Brown.png')
const lea_brown     = preload('res://Textures/Colour Overlays/Leather/Brown.png')
const lea_tan       = preload('res://Textures/Colour Overlays/Leather/Tan.png')

const textures = {
	"Red" : [
		neo_red,
		lea_red
		],
	"Orange" : [
		neo_orange,
		lea_orange
		],
	"Golden" : [
		neo_yellow,
		lea_golden
		],
	"Yellow" : [
		neo_yellow,
		lea_yellow
		],
	"Lime" : [
		neo_lime,
		lea_lime
		],
	"Hunter" : [
		neo_hunter,
		lea_hunter
		],
	"Aqua" : [
		neo_aqua,
		lea_baby_blue
		],
	"Baby Blue" : [
		neo_aqua,
		lea_baby_blue
		],
	"Cobalt" : [
		neo_cobalt,
		lea_turquoise
		],
	"Turquoise" : [
		neo_cobalt,
		lea_turquoise
		],
	"Royal" : [
		neo_royal,
		lea_med_blue
		],
	"Med Blue" : [
		neo_royal,
		lea_med_blue
		],
	"Navy" : [
		neo_navy,
		lea_dk_blue
		],
	"DK Blue" : [
		neo_navy,
		lea_dk_blue
		],
	"Purple" : [
		neo_purple,
		lea_purple
		],
	"Pink" : [
		neo_pink,
		lea_hot_pink
		],
	"Hot Pink" : [
		neo_pink,
		lea_hot_pink
		],
	"Pink " : [
		neo_white,
		lea_pink
		],
	"White" : [
		neo_white,
		lea_white
		],
	"Grey" : [
		neo_grey,
		lea_grey
		],
	"Matte" : [
		neo_black,
		lea_black
		],
	"Black" : [
		neo_black,
		lea_black
		],
	"Shiny" : [
		neo_shiny,
		lea_black
		],
	"DK Brown" : [
		neo_black,
		lea_dk_brown
		],
	"Textured" : [
		neo_textured,
		lea_black
		],
	"Camo" : [
		neo_camo,
		lea_hunter
		],
	"Brown" : [
		neo_brown,
		lea_brown
		],
	"Tan" : [
		neo_brown,
		lea_tan
		]
	}

const black_snaps = preload('res://Textures/Colour Overlays/Leather/Snaps/Black.png')
const silver_snaps = preload('res://Textures/Colour Overlays/Leather/Snaps/Silver.png')
const brass_snaps = preload('res://Textures/Colour Overlays/Leather/Snaps/Brass.png')

const snaps_textures = [black_snaps, silver_snaps, brass_snaps]

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

const neoprene_shader : ShaderMaterial = preload('res://Materials/Decrypt Image Neoprene.material')
const leather_shader : ShaderMaterial = preload('res://Materials/Decrypt Image Leather.material')

const snaps_shader : ShaderMaterial = preload('res://Materials/Decrypt Image Snaps.material')
const snaps_groups = [
	"face_snaps",
	"back_eyelets",
	"muzzle_eyelets"
	]

var body_colour : Color

func _ready():
	OS.min_window_size = Vector2(700, 400)

var hood_type_change_node : Button
func _hood_type_change(index):
	hood_type_change_node._hood_style_selected(index)
	

func _change_colour(index, node_group):
	_settings_changed(node_group, names.keys().find(index))
	if node_group == "CrownNeck" or node_group == "Base":
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
					
	else:
		change_texture(index, node_group)
		global_update_selection_text(index, node_group)

func change_colour_base_crownneck(index):
	for i in ["CrownNeck", "Base"]:
		change_texture(index, i)
		global_update_selection_text(index, i)
		_settings_changed(i, names.keys().find(index))

func change_texture(index, node_group):
	neoprene_shader.set_shader_param(node_group.replacen(" ", "_").to_lower(), textures[index][0])
	leather_shader.set_shader_param(node_group.replacen(" ", "_").to_lower(), textures[index][1])

func change_snaps_texture(index, node_group):
	snaps_shader.set_shader_param(node_group.replacen(" ", "_").to_lower(), snaps_textures[index])

func global_update_selection_text(index, node_group):
	for i in get_tree().get_nodes_in_group(node_group):
		if i.is_in_group("Colour Selection Button"):
			if i.is_in_group("Leather"):
				i.text = names[index][1]
			else:
				i.text = names[index][0]

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
		if catagory == "Eyeglass Slots" or catagory == "Ear Holes" or catagory == "Jowl":
			if i.is_in_group(catagory):
				i.visible = pressed
		elif catagory == "Brow Style" and i.is_in_group("Brow Style"):
			if i.is_in_group("Brow Double"):
				i.visible = index != 0
			elif i.is_in_group("Brow Single"):
				i.visible = index == 0
		elif catagory == "Muzzle Length":
			if i.is_in_group("Muzzle Base"):
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
		elif catagory == "Muzzle Detail B":
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
					
		elif catagory == "Ear Style":
			if i.is_in_group("Ear"):
				if (i.is_in_group("Leather") and index != 1) or !i.is_in_group("Leather"):
					if i.is_in_group(hood_options[index + 5] + " Ear"):
						i.visible = true
					else:
						i.visible = false
		elif catagory == "Muzzle Type":
			if i.is_in_group("Muzzle Preview"):
				i.visible = i.is_in_group(muzzle_types[index] + " Muzzle")
			
		elif snap_node_groups.find(catagory) != -1:
			if i.is_in_group("SnapsEyelets"):
				change_snaps_texture(index, snaps_groups[snap_node_groups.find(catagory)])

var snap_colours = ["Snap Black", "Snap Silver", "Snap Brass"]
func change_buttons(catagory : String, index : int, pressed : bool):
	if catagory == "Jowl":
		for i in get_tree().get_nodes_in_group("Jowl Colour"):
			i.disabled = !pressed
	elif catagory == "Muzzle Detail B":
		for i in get_tree().get_nodes_in_group("Muzzle Detail B Colour"):
			i.disabled = index < 2
	for i in get_tree().get_nodes_in_group("Hood Option Button"):
		if i.is_in_group("Preview"):
			if i.node_group == catagory:
				if catagory == "Eyeglass Slots" or catagory == "Ear Holes" or catagory == "Jowl":
					i.text = "Yes" if pressed else "No"
				elif catagory == "Brow Style":
					i.text = "Single" if index == 0 else "Double"
				elif catagory == "Muzzle Length":
					if (i.is_in_group("Leather") and index == 0):
						i.text = hood_options[9]
					else:
						i.text = hood_options[index + 8]
				elif catagory == "Muzzle Detail B":
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
						
				elif catagory == "Ear Style":
					if (i.is_in_group("Leather") and index != 1) or !i.is_in_group("Leather"):
						i.text = hood_options[index + 5]
				elif catagory == "Muzzle Type":
					if i.is_in_group("Muzzle Type Button"):
						i.text = muzzle_types[index]
						for ii in get_tree().get_nodes_in_group("Muzzle Options"):
							ii.visible = ii.is_in_group(muzzle_types[index] + " Options")
				
				elif snap_node_groups.find(catagory) != -1:
					if i.is_in_group(catagory):
						if i.is_in_group("Circle Button"):
							if i.is_in_group(snap_colours[index]):
								i.pressed = true
						else:
							i.text = hood_options[index]
		else:
			if i.catagory == catagory:
				
				if i.button_index == index:
					i.pressed = pressed
				if catagory == "Muzzle Length":
					if (i.is_in_group("Leather") and index == 0) and i.button_index == 1:
						i.pressed = true
				elif catagory == "Muzzle Detail B":
					if i.is_in_group("Frisky"):
						if i.is_in_group("4 Holes"):
							i.visible = index == 1
					else:
						if index == 4:
							if i.button_index == 0:
								i.pressed = true

var allow_generate_code = true
func _settings_changed(catagory : String, index : int):
	if !HoodCodeManager.neoprene_colour_groups.has(catagory):
		HoodCodeManager.settings[HoodCodeManager.node_groups.find(catagory)] = index
	else: 
		HoodCodeManager.settings[HoodCodeManager.node_groups.find(catagory)] = HoodCodeManager.neoprene_colours.find(names.keys()[index])
	Price._set_price()
