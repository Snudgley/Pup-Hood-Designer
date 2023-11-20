extends Camera2D

const form_size = Vector2(4400, 3400)
onready var parent = get_parent()

var zoom_level = 1
var drag_offset : Vector2
var is_width_bigger : bool

func _ready():
	yield(get_tree().create_timer(0.1), 'timeout')
	_readjust_camera()

func _readjust_camera():
	is_width_bigger = parent.rect_size.x * 0.7727272727272727 > parent.rect_size.y
	var boundary = form_size - parent.rect_size * zoom
	var half_boundary = boundary * 0.5
	if is_width_bigger:
		zoom.y = form_size.y / (parent.rect_size.y * zoom_level)
		zoom.x = zoom.y
		var max_drag_offset = boundary * Vector2(int(boundary.x > 0), int(boundary.y > 0))
		max_drag_offset.x *= 0.5
		drag_offset.x = clamp(drag_offset.x, -max_drag_offset.x, max_drag_offset.x)
		drag_offset.y = clamp(drag_offset.y, -half_boundary.y, max_drag_offset.y - half_boundary.y)
		position = half_boundary + drag_offset
	else:
		zoom.x = form_size.x / (parent.rect_size.x * zoom_level)
		zoom.y = zoom.x
		var max_drag_offset = boundary * Vector2(int(boundary.x > 0), int(boundary.y > 0))
		max_drag_offset.x *= 0.5
		drag_offset.x = clamp(drag_offset.x, -max_drag_offset.x, max_drag_offset.x)
		drag_offset.y = clamp(drag_offset.y, -half_boundary.y, max_drag_offset.y - half_boundary.y)
		position = half_boundary + drag_offset + Vector2(0, half_boundary.y * int(boundary.y < 0))

var dragging : bool
const zoom_amount = 0.05
func _input(event):
	if event is InputEventMouseButton:
		if is_visible_in_tree():
			if event.button_index == BUTTON_WHEEL_UP:
				_zoom(1 + zoom_amount)
			elif event.button_index == BUTTON_WHEEL_DOWN:
				_zoom(1 - zoom_amount)
			elif event.button_index == BUTTON_MIDDLE:
				dragging = event.pressed
	elif event is InputEventMouseMotion and dragging:
		if is_width_bigger:
			drag_offset -= event.relative * Vector2(form_size.y / parent.rect_size.y, form_size.y / parent.rect_size.y) * (1.0 / zoom_level)
		else:
			drag_offset -= event.relative * Vector2(form_size.x / parent.rect_size.x, form_size.x / parent.rect_size.x) * (1.0 / zoom_level)
		_readjust_camera()

func _zoom(delta):
	zoom_level *= delta
	zoom_level = clamp(zoom_level, 1, 5)
	_readjust_camera_twice_to_fix_slight_bug()

func _readjust_camera_twice_to_fix_slight_bug():
	_readjust_camera()
	_readjust_camera()
