extends LineEdit

func _ready():
	HoodCodeManager.connect('generated_code', self, '_set_text')

func _on_code_entered(code):
	HoodCodeManager._code_to_settings(code)

func _set_text(some_text : String):
	text = some_text
