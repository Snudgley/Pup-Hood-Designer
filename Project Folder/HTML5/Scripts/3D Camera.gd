extends Camera

var mouse_in_viewport : bool = true

var rot_resistance_min : float
var rot_resistance_max : float

var zoom_resistance_min : float
var zoom_resistance_max : float


export var rot_soft_clamp := [ -70, 60 ]
export var rot_hard_clamp := [ -100, 90 ]

export var zoom_soft_clamp := [2, 8]
export var zoom_hard_clamp := [1, 10]

onready var rotation_node : Spatial = get_parent()
onready var camera_node : Camera = self
onready var tween : Tween
onready var viewport : Viewport = get_viewport()
onready var viewport_rect = viewport.get_parent().get_rect()

func _ready():
	rot_resistance_min = 100 / (rot_soft_clamp[0] - rot_hard_clamp[0])
	rot_resistance_max = 100 / (rot_hard_clamp[1] - rot_soft_clamp[1])
	
	zoom_resistance_min = 100 / (zoom_soft_clamp[0] - zoom_hard_clamp[0])
	zoom_resistance_max = 100 / (zoom_hard_clamp[1] - zoom_soft_clamp[1])
	
	viewport.get_parent().connect("draw", self, "_viewport_redrawn")

func _viewport_redrawn():
	viewport_rect = viewport.get_parent().get_global_rect()

var orbit_up = false
var orbit_down = false
var orbit_pressed = false
var zoom_in = 0.0
var zoom_out = 0.0
var orbit_motion = Vector2(0,0)
var zoom_motion = 0.0

var warping_mouse = 0
var viewport_mouse_position

const rect_border = 1

func _input(event):
	viewport_mouse_position = viewport.get_mouse_position()
	mouse_in_viewport = viewport_rect.has_point(viewport_mouse_position + viewport_rect.position) and viewport.get_parent().visible and !DetailManager.colours_popup.visible and !DetailManager.colour_picker.visible
	
	if warping_mouse:
		warping_mouse -= 1

	if mouse_in_viewport:
		if !event is InputEventMouseMotion:
			if !zoom_in or !zoom_out:
				if event is InputEventMouseButton:
					match event.button_index:
						BUTTON_MIDDLE:
							orbit_pressed = event.pressed
						BUTTON_MASK_RIGHT:
							match event.pressed:
								true:
									get_tree().get_nodes_in_group("Picker Camera")[0].global_transform = global_transform
									_get_group()
				
			if event is InputEventMouseButton:
				if event.button_index == BUTTON_WHEEL_UP:
					zoom_motion -= int(event.pressed) * 2
			
				if event.button_index == BUTTON_WHEEL_DOWN:
					zoom_motion += int(event.pressed) * 2
	
	elif !event is InputEventMouseMotion and \
		!zoom_in or !zoom_out and \
		event is InputEventMouseButton and \
		event.button_index == BUTTON_MIDDLE and \
		!event.pressed:
			orbit_pressed = false
	
	if !warping_mouse:
		if orbit_pressed:
			if event is InputEventMouseMotion:
				orbit_motion += -event.relative * 0.25
				orbit_up = orbit_motion.y < 0
				orbit_down = orbit_motion.y > 0
				_warp_mouse()
		
		if zoom_in and zoom_out:
			if event is InputEventMouseMotion:
				zoom_motion += event.relative.y * 0.5


func _warp_mouse():
	if viewport_mouse_position.x > viewport_rect.size.x - rect_border:
		get_viewport().warp_mouse(Vector2(viewport_rect.position.x, viewport_mouse_position.y + viewport_rect.position.y))
		warping_mouse = 3
	elif viewport_mouse_position.x < rect_border:
		get_viewport().warp_mouse(Vector2(viewport_rect.size.x + viewport_rect.position.x, viewport_mouse_position.y + viewport_rect.position.y))
		warping_mouse = 3
	if viewport_mouse_position.y > viewport_rect.size.y - rect_border:
		get_viewport().warp_mouse(Vector2(viewport_mouse_position.x + viewport_rect.position.x, viewport_rect.position.y))
		warping_mouse = 3
	elif viewport_mouse_position.y < rect_border:
		get_viewport().warp_mouse(Vector2(viewport_mouse_position.x + viewport_rect.position.x, viewport_rect.size.y + viewport_rect.position.y))
		warping_mouse = 3


func _physics_process(delta):
	_manage_orbit()
	_manage_zoom()
	_manage_inertia()

func _manage_orbit():
	var resistance = 1
	var pushback = 0
	
	# Squish
	if orbit_motion.y > 0:
		if rotation_node.rotation_degrees.x > rot_soft_clamp[1]:
			if orbit_up:
				resistance = (1 + (rot_soft_clamp[1] - rotation_node.rotation_degrees.x) * rot_resistance_max * 0.01) * 0.5
			else:
				pushback = (rot_soft_clamp[1] - rotation_node.rotation_degrees.x) * rot_resistance_max * 0.05
	if orbit_motion.y < 0:
		if rotation_node.rotation_degrees.x < rot_soft_clamp[0]:
			if orbit_down:
				resistance = (1 - (rot_soft_clamp[0] - rotation_node.rotation_degrees.x) * rot_resistance_min * 0.01) * 0.5
			else:
				pushback = (rot_soft_clamp[0] - rotation_node.rotation_degrees.x) * rot_resistance_min * 0.05
		else:
			pushback = 0
	
	
	rotation_node.rotation_degrees += Vector3(
		orbit_motion.y * resistance + pushback,
		orbit_motion.x,
		0
	)
	rotation_node.rotation_degrees.x = clamp(rotation_node.rotation_degrees.x, rot_hard_clamp[0], rot_hard_clamp[1])

func _manage_zoom():
	var resistance = 1
	var pushback = 0
	if true: # Squish
		if zoom_motion > 0:
			if camera_node.translation.z > zoom_soft_clamp[1]:
				if zoom_out:
					resistance = (1 + (zoom_soft_clamp[1] - camera_node.translation.z) * zoom_resistance_max * 0.01) * 0.5
				else:
					pushback = (zoom_soft_clamp[1] - camera_node.translation.z) * zoom_resistance_max * 0.05
		if zoom_motion < 0:
			if camera_node.translation.z < zoom_soft_clamp[0]:
				if zoom_in:
					resistance = (1 - (zoom_soft_clamp[0] - camera_node.translation.z) * zoom_resistance_min * 0.01) * 0.5
				else:
					pushback = (zoom_soft_clamp[0] - camera_node.translation.z) * zoom_resistance_min * 0.05
			else:
				pushback = 0
	
	camera_node.translation.z += (zoom_motion * 0.1) * resistance + (pushback * 0.1)
	camera_node.translation.z = clamp(camera_node.translation.z, zoom_hard_clamp[0], zoom_hard_clamp[1])

func _manage_inertia():
	orbit_motion *= 0.6
	if !zoom_in or !zoom_out:
		zoom_motion *= 0.6

var node_group

func _get_group():
	var picker_viewport : Viewport = get_tree().get_nodes_in_group("Picker Viewport")[0]
	picker_viewport.render_target_update_mode = Viewport.UPDATE_ONCE
	yield(get_tree(), 'idle_frame')
	yield(get_tree(), 'idle_frame')
	var img = picker_viewport.get_texture().get_data()
	img.lock()
	var pixel_colour = img.get_pixelv( Vector2(
		BigMaths._smart_divide(
			viewport_mouse_position.x, 
			viewport.size.x),
		BigMaths._smart_divide(
			viewport_mouse_position.y, 
			viewport.size.y)
		) * picker_viewport.size)
	if pixel_colour.v > 0.9:
		if pixel_colour.s < 0.1:
			_body_colour_popup()
		else:
			node_group = round(pixel_colour.h * 15)
			_hood_colour_popup()

func _body_colour_popup():
	DetailManager.colour_picker._popup()

func _hood_colour_popup():
	DetailManager.colours_popup._popup(DetailManager.node_groups[node_group], HoodCodeManager.settings[0] == 5)
