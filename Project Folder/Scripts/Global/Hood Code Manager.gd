extends Node

# 1895582315785361442377564160 possible combinations

const conversion_table = [
	"0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
	"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
	"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
	"_", ":", "~", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "+", "=", "<", ">", "?", "/", "{", "}", "[", "]", ";", "\\"
	]
const options_in_setting = [6, 5, 3, 28, 28, 28, 28, 28, 28, 18, 28, 18, 18, 28, 28, 28, 28, 28, 4, 3, 3, 3, 3, 3, 2, 2, 2, 2]
const code_multiples = [
	"315930385964226907062927360", 
	"63186077192845381412585472", 
	"21062025730948460470861824", 
	"752215204676730731102208", 
	"26864828738454668967936", 
	"959458169230523891712", 
	"34266363186804424704", 
	"1223798685243015168", 
	"43707095901536256", 
	"2428171994529792", 
	"86720428376064", 
	"4817801576448", 
	"267655643136", 
	"9559130112", 
	"341397504", 
	"12192768", 
	"435456", 
	"15552", 
	"3888", 
	"1296", 
	"432", 
	"144", 
	"48", 
	"16", 
	"8", 
	"4", 
	"2", 
	"1"
	]
const node_groups = [
	"Hood Type", 
	"Hood Size", 
	"Muzzle Type", 
	"Base", 
	"CrownNeck", 
	"Brow", 
	"Bridge", 
	"Muzzle", 
	"Nose", 
	"Lip", 
	"Chin", 
	"Inner Chin", 
	"Tongue", 
	"Ear A", 
	"Ear B", 
	"Ear C", 
	"Jowl Colour", 
	"Muzzle Detail B Colour", 
	"Muzzle Detail B", 
	"Lacing Eyelets", 
	"Snaps", 
	"Muzzle Eyelets", 
	"Muzzle Length", 
	"Ear Style", 
	"Brow Style", 
	"Jowl", 
	"Ear Holes", 
	"Eyeglass Slots"
	]
const colour_groups = [
	"Base", 
	"CrownNeck", 
	"Brow", 
	"Bridge", 
	"Muzzle", 
	"Nose", 
	"Chin", 
	"Ear A", 
	"Ear B", 
	"Ear C", 
	"Jowl Colour", 
	"Muzzle Detail B Colour"
	]
const neoprene_colour_groups = [
	"Lip", 
	"Inner Chin", 
	"Tongue"
	]
const neoprene_colours = [
	"Red", 
	"Orange", 
	"Yellow", 
	"Lime", 
	"Hunter", 
	"Aqua", 
	"Cobalt", 
	"Royal", 
	"Navy", 
	"Purple", 
	"Pink", 
	"White", 
	"Grey", 
	"Shiny", 
	"Matte", 
	"Textured", 
	"Camo", 
	"Brown"
	]

const leather_colours = [
	"Red",
	"Orange",
	"Golden",
	"Yellow",
	"Lime",
	"Hunter",
	"Turquoise",
	"Baby Blue",
	"Med Blue",
	"DK Blue",
	"Purple",
	"Hot Pink",
	"Pink ",
	"White",
	"Grey",
	"Black",
	"DK Brown",
	"Brown",
	"Tan"
	]

var settings : PoolIntArray = [1, 1, 1, 22, 22, 18, 18, 18, 22, 11, 22, 11, 0, 18, 22, 22, 18, 22, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0] 

signal generated_code

func _settings_to_code():
	var output_string = ""
	var number : String = "0"
	for i in options_in_setting.size() - 1:
		var multiply_number : String = "1"
		for ii in options_in_setting.size() - i - 1:
			multiply_number = BigMaths.big_multiply(multiply_number, String(options_in_setting[ii + i + 1]))
		multiply_number = BigMaths.big_multiply(multiply_number, String(settings[i]))
		number = BigMaths.big_add(number, multiply_number)
	number = BigMaths.big_add(number, String(settings[settings.size() - 1]))
	
	var output = _B10_to_B64(number)
	print(number, " to code")
	print(settings, " to code")
	emit_signal('generated_code', output)
	return output

func _code_to_settings(code : String):
	
	if code == "":
		_input_invalid()
		return
	
	var result_array : Array
	var number = _B64_to_B10(code)
	if number == "Invalid":
		_input_invalid()
		return
	print(number, " to settings")
	
	for i in options_in_setting.size():
		var partial = BigMaths.big_divide(number, code_multiples[i], 40)
		var partial_stripped = partial.left(partial.find(".")) if partial.find(".") != -1 else partial
		settings[i] = int(partial_stripped)
		number = BigMaths.big_multiply(BigMaths.big_subtract(partial, partial_stripped), code_multiples[i])
		number = BigMaths.big_round(number)
	var settings_new = settings
	print(settings, " to settings")
	
	for i in options_in_setting.size():
		if colour_groups.has(node_groups[i]):
			DetailManager._change_colour(DetailManager.names.keys()[settings_new[i]], node_groups[i])
		elif neoprene_colour_groups.has(node_groups[i]):
			DetailManager._change_colour(neoprene_colours[settings_new[i]], node_groups[i])
		else:
			if node_groups[i] == "Hood Type":
				DetailManager._hood_type_change(settings_new[i])
			elif node_groups[i] == "Eyeglass Slots" or node_groups[i] == "Ear Holes" or node_groups[i] == "Jowl":
				DetailManager.option_changed(node_groups[i], 0, settings_new[i])
			else:
				DetailManager.option_changed(node_groups[i], settings_new[i], true)
	DetailManager._change_colour(DetailManager.names.keys()[settings_new[4]], node_groups[4])

func _input_invalid():
	print("Invalid Input")
	for output in get_tree().get_nodes_in_group("output code"):
		var previous_text = output.text
		output.text = "Invalid"
		output.editable = false
		yield(get_tree().create_timer(1.0), 'timeout')
		output.text = previous_text
		output.editable = true

func _B10_to_B64(value : String):
	var B64 : String
	while(value != "0"):
		var remainder : String
		var new_value = BigMaths.big_divide(value, "64", 0)
		remainder = new_value
		remainder = BigMaths.big_subtract(value, BigMaths.big_multiply(remainder, "64"))
		value = new_value
		B64 = conversion_table[int(remainder)] + B64
	return B64

const Powers64 = ["1", "64", "4096", "262144", "16777216", "1073741824", "68719476736", "4398046511104", "281474976710656", "18014398509481984", "1152921504606846976", "73786976294838206464", "4722366482869645213696", "302231454903657293676544", "19342813113834066795298816", "1237940039285380274899124224"]
func _B64_to_B10(value : String):
	var B64_array : Array
	for i in value.length():
		B64_array.append(conversion_table.find(value.right(i).left(1)))
	var integer : String
	for i in B64_array.size():
		integer = BigMaths.big_add(integer, BigMaths.big_multiply(String(B64_array[i]), Powers64[B64_array.size() - i - 1]))
	return integer

func _B10_to_B88(value : String):
	var B88 : String
	while(value != "0"):
		var remainder : String
		var new_value = BigMaths.big_divide(value, "88", 0)
		remainder = new_value
		remainder = BigMaths.big_subtract(value, BigMaths.big_multiply(remainder, "88"))
		value = new_value
		B88 = conversion_table[int(remainder)] + B88
	return B88

const Powers88 = ["1", "88", "7744", "681472", "59969536", "5277319168", "464404086784", "40867559636992", "3596345248055296", "316478381828866048", "27850097600940212224", "2450808588882738675712", "215671155821681003462656", "18979061712307928304713728", "1670157430683097690814808064", "146973853900112596791703109632"]
func _B88_to_B10(value : String):
	var B88_array : Array
	for i in value.length():
		var to_append = conversion_table.find(value.right(i).left(1))
		if to_append == -1:
			return "Invalid"
		B88_array.append(to_append)
	var integer : String
	if B88_array.size() - 1 > Powers88.size():
		return "Invalid"
	for i in B88_array.size():
		integer = BigMaths.big_add(integer, BigMaths.big_multiply(String(B88_array[i]), Powers88[B88_array.size() - i - 1]))
	return integer

func generate_code_multiples(): # Use this if you need to add more options
	printt(options_in_setting.size(), code_multiples.size())
	var previous_result = String(1)
	for i in options_in_setting.size() - 1:
		previous_result = BigMaths.big_multiply(String(options_in_setting[-i - 1]), previous_result)
		print(previous_result)
	
	previous_result = BigMaths.big_multiply(String(options_in_setting[-options_in_setting.size()]), previous_result)
	print("")
	printt(previous_result, "Possible combinations")
