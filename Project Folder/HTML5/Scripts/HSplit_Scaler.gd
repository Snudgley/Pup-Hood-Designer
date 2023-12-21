extends HSplitContainer

var offset : float
var half_rect_x = rect_size.x * 0.5

func _ready():
	connect('dragged', self, "_on_HSplitContainer_dragged")

onready var render = get_node("Render")
onready var picker_viewport = render.get_node("3D Picker Viewport")

func _draw():
	half_rect_x = rect_size.x * 0.5
	split_offset = offset * half_rect_x
	picker_viewport.size = Vector2(int(render.rect_size.x * 0.2), int(render.rect_size.y * 0.2))

func _on_HSplitContainer_dragged(hsplit_offset):
	offset = BigMaths._smart_divide(clamp(split_offset, -half_rect_x, half_rect_x ), half_rect_x)
