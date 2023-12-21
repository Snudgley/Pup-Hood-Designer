extends Node

func _smart_divide(val1 : float, val2 : float):
	match val1:
		0.0:
			return 0
		_:
			return val1 / val2

static func string_to_array(num_string : String = "0"):
	var num_array : PoolIntArray
	for i in num_string.length():
		if num_string.right(num_string.length() - 1 - i).left(1) != ".":
			num_array.append(int(num_string.right(num_string.length() - 1 - i).left(1)))
	return num_array

func big_multiply(num1 : String = "0", num2 : String = "0"):
	if num1 == "0" or num2 == "0":
		return "0"
	
	var negative : bool
	if num1.left(1) == "-" and num2.left(1) == "-":
		num1 = num1.right(1)
		num2 = num2.right(1)
	elif num1.left(1) == "-" and num2.left(1) != "-":
		num1 = num1.right(1)
		negative = true
	elif num1.left(1) != "-" and num2.left(1) == "-":
		num2 = num2.right(1)
		negative = true
	
	var decimal_places : int
	var num1_decimals : int
	var num2_decimals : int 
	
	if num1.find_last(".") != -1:
		num1_decimals = num1.length() - num1.find_last(".") - 1
	if num2.find_last(".") != -1:
		num2_decimals = num2.length() - num2.find_last(".") - 1
	
	decimal_places = num1_decimals + num2_decimals
	var redundant_decimals : int
	if decimal_places > 0:
	
		if num1_decimals > num2_decimals:
			for i in num1_decimals - num2_decimals:
				num2 += "0"
				redundant_decimals += 1
		elif num1_decimals < num2_decimals:
			for i in num2_decimals - num1_decimals:
				num1 += "0"
				redundant_decimals += 1
	
	var num1_array : PoolIntArray = string_to_array(num1)
	var num2_array : PoolIntArray = string_to_array(num2)
	
	var parts_to_multiply : Array = [num2_array, num1_array] if num2_array.size() < num1_array.size() else [num1_array, num2_array]
	var parts_to_add : Array
	for i in parts_to_multiply[0].size():
		
		var multiply_carry_over : int
		parts_to_add.append([])
		for zeros in i:
			parts_to_add[i].append(0)
		
		for ii in parts_to_multiply[1].size():
			var multiply_mini_result : String = String(int(parts_to_multiply[0][i]) * int(parts_to_multiply[1][ii]) + multiply_carry_over)
			multiply_carry_over = int(multiply_mini_result.left(multiply_mini_result.length() - 1))
			parts_to_add[i].append(int(multiply_mini_result) - (multiply_carry_over * 10))
		if multiply_carry_over != 0:
			parts_to_add[i].append(multiply_carry_over)
	
	var result_array : Array
	var add_carry_over : int
	result_array.resize(parts_to_add[-1].size())
	result_array.fill(0)
	
	for i in parts_to_add[-1].size():
		var partial_result : int
		for ii in parts_to_add.size():
			if parts_to_add[ii].size() > i:
				partial_result += parts_to_add[ii][i]
		partial_result += add_carry_over
		add_carry_over = int(String(partial_result).left(String(partial_result).length() - 1))
		result_array[i] = partial_result - (add_carry_over * 10)
	
	if add_carry_over != 0:
		result_array.append(add_carry_over)
	
	var result : String
	
	for i in redundant_decimals:
		result_array.remove(0)
	
	for i in result_array.size():
		if i == 0:
			if negative:
				result += "-"
		if result_array.size() - i - 1 == decimal_places - 1:
			result += "."
		result += String(result_array[-i - 1])
	
	while result.left(1) == "0":
		result = result.right(1)
	if result.left(1) == ".":
		result = "0" + result
	
	if result.find(".") != -1:
		while result.right(result.length() - 1) == "0":
			result = result.left(result.length() - 1)
		if result.right(result.length() - 1) == ".":
			result = result.left(result.length() - 1)
	
	return result

func big_add(num1 : String = "0", num2 : String = "0"):
	if num1 == "0" and num2 != "0":
		return num2
	elif num1 != "0" and num2 == "0":
		return num1
	elif num1 == "0" and num2 == "0":
		return "0"
	
	var negative : bool
	if num1.left(1) == "-" and num2.left(1) == "-":
		num1 = num1.right(1)
		num2 = num2.right(1)
		negative = true
	elif num1.left(1) == "-" and num2.left(1) != "-":
		num1 = num1.right(1)
		var alt_result : String = big_subtract(num1, num2)
		
		if alt_result.left(1) == "-":
			return alt_result.right(1)
		else:
			return "-" + alt_result
	elif num1.left(1) != "-" and num2.left(1) == "-":
		num2 = num2.right(1)
		return big_subtract(num1, num2)
	
	var decimal_places : int
	var num1_decimals : int
	var num2_decimals : int 
	
	if num1.find_last(".") != -1:
		num1_decimals = num1.length() - num1.find_last(".") - 1
	if num2.find_last(".") != -1:
		num2_decimals = num2.length() - num2.find_last(".") - 1
	
	decimal_places = max(num1_decimals, num2_decimals)
	
	if num1_decimals > num2_decimals:
		for i in num1_decimals - num2_decimals:
			num2 += "0"
	elif num1_decimals < num2_decimals:
		for i in num2_decimals - num1_decimals:
			num1 += "0"
	else:
		decimal_places = num1_decimals
	
	var parts_to_add : Array = [string_to_array(num2), string_to_array(num1)] if num2.length() < num1.length() else [string_to_array(num1), string_to_array(num2)]
	
	var result_array : Array
	var add_carry_over : int
	result_array.resize(parts_to_add[-1].size())
	result_array.fill(0)
	
	for i in parts_to_add[-1].size():
		var partial_result : int
		for ii in parts_to_add.size():
			if parts_to_add[ii].size() > i:
				partial_result += parts_to_add[ii][i]
		partial_result += add_carry_over
		add_carry_over = int(String(partial_result).left(String(partial_result).length() - 1))
		result_array[i] = partial_result - (add_carry_over * 10)
	
	if add_carry_over != 0:
		result_array.append(add_carry_over)
	
	var result : String
	
	for i in result_array.size():
		if i == 0:
			if negative:
				result += "-"
		if result_array.size() - i - 1 == decimal_places - 1:
			result += "."
		result += String(result_array[-i - 1])
	
	while result.left(1) == "0":
		result = result.right(1)
	
	if decimal_places != 0:
		var removed_decimals : int
		while result.right(result.length() - 1) == "0":
			result = result.left(result.length() - 1)
			removed_decimals += 1
			if removed_decimals == decimal_places:
				result = result.left(result.length() - 1)
	
	return result


func big_divide(dividend : String = "0", divisor : String = "0", maximum_decimals : int = 0):
	if divisor == "0" or dividend == "0":
		return "0"
	elif divisor == dividend:
		return "1"
	elif divisor == "1":
		return dividend
	
	var negative : bool
	if divisor.left(1) == "-" and dividend.left(1) == "-":
		divisor = divisor.right(1)
		dividend = dividend.right(1)
	elif divisor.left(1) == "-" and dividend.left(1) != "-":
		divisor = divisor.right(1)
		negative = true
	elif divisor.left(1) != "-" and dividend.left(1) == "-":
		dividend = dividend.right(1)
		negative = true
	
	var divisor_decimal_to_right : int
	var dividend_with_moved_decimal : String
	var dividend_decimal_place : int
	
	if divisor.find(".") != -1:
		while divisor.right(divisor.length()-1) == "0":
			divisor = divisor.left(divisor.length()-1)
			if divisor.right(divisor.length()-1) == ".":
				divisor = divisor.left(divisor.length()-1)
		
		divisor_decimal_to_right = divisor.length() - divisor.find(".") - 1
		
	if dividend.find(".") == -1:
		for i in divisor_decimal_to_right:
			dividend = dividend + "0"
		dividend = dividend + "."
		for i in maximum_decimals:
			dividend = dividend + "0"
		dividend_with_moved_decimal = dividend
		dividend_decimal_place = dividend.find(".") + divisor_decimal_to_right - 1
	else:
		dividend_decimal_place = dividend.find(".") + divisor_decimal_to_right - 1
		dividend = dividend.replace(".", "")
		for i in dividend_decimal_place - dividend.length() + 1:
			dividend = dividend + "0"
		for i in dividend.length():
			dividend_with_moved_decimal = dividend_with_moved_decimal + dividend.right(i).left(1)
			if i == dividend_decimal_place:
				dividend_with_moved_decimal = dividend_with_moved_decimal + "."
		if dividend_with_moved_decimal.length() - dividend_with_moved_decimal.find(".") - 1 < maximum_decimals:
			for i in maximum_decimals - (dividend_with_moved_decimal.length() - dividend_with_moved_decimal.find(".") - 1):
				dividend_with_moved_decimal = dividend_with_moved_decimal + "0"
		else:
			dividend_with_moved_decimal = dividend_with_moved_decimal.left(dividend_with_moved_decimal.length() - (dividend_with_moved_decimal.length() - dividend_with_moved_decimal.find(".") - 1) + maximum_decimals)
	
	divisor = divisor.replace(".", "")
	var dividend_array = []
	
	for i in dividend_with_moved_decimal.length():
		if dividend_with_moved_decimal.right(i).left(1) != ".":
			dividend_array.append(int(dividend_with_moved_decimal.right(i).left(1)))
	
	var result_array : Array
	var partial_dividend : String
	
	for i in dividend_array:
		if partial_dividend != "0":
			partial_dividend = partial_dividend + String(i)
		else:
			partial_dividend = String(i)
		
		if is_less_than(partial_dividend, divisor):
			result_array.append(0)
		else:
			var times_divisor_goes_into_partial : int
			var subtract_partial = partial_dividend
			while is_less_than(divisor, subtract_partial) or divisor == subtract_partial:
				subtract_partial = big_subtract(subtract_partial, divisor)
				times_divisor_goes_into_partial += 1
			result_array.append(times_divisor_goes_into_partial)
			partial_dividend = big_subtract(partial_dividend, big_multiply(divisor, String(times_divisor_goes_into_partial)))
	
	var result : String
	var has_decimal : bool
	
	for i in result_array.size():
		result = result + String(result_array[i])
		if i == dividend_decimal_place and maximum_decimals != 0:
			result = result + "."
			has_decimal = true
	
	while result.left(1) == "0":
		result = result.right(1)
	if result.left(1) == ".":
		result = "0" + result
	if has_decimal:
		while result.right(result.length() - 1) == "0":
			result = result.left(result.length() - 1)
		if result.right(result.length() - 1) == ".":
			result = result.left(result.length() - 1)
	
	if result == "":
		result = "0"
	
	return result

func big_subtract(num1 : String = "0", num2 : String = "0"):
	if num1 == "0" and num2 != "0":
		return "-" + num2
	elif num2 == "0" and num1 != "0":
		return num1
	elif num1 == "0" and num2 == "0":
		return "0"
	elif num1 == num2:
		return "0"
	
	var overright_negative : bool
	
	if num1.left(1) == "-" and num2.left(1) == "-":
		num1 = num1.right(1)
		num2 = num2.right(1)
		overright_negative = true
	elif num1.left(1) == "-" and num2.left(1) != "-":
		num1 = num1.right(1)
		return "-" + big_add(num1, num2)
	elif num1.left(1) != "-" and num2.left(1) == "-":
		num2 = num2.right(1)
		return big_add(num1, num2)
	
	var decimal_places : int
	var num1_decimals : int
	var num2_decimals : int 
	
	if num1.find_last(".") != -1:
		num1_decimals = num1.length() - num1.find_last(".") - 1
	if num2.find_last(".") != -1:
		num2_decimals = num2.length() - num2.find_last(".") - 1
	
	decimal_places = max(num1_decimals, num2_decimals)
	
	if num1_decimals > num2_decimals:
		for i in num1_decimals - num2_decimals:
			num2 += "0"
	elif num1_decimals < num2_decimals:
		for i in num2_decimals - num1_decimals:
			num1 += "0"
	
	var negative : bool
	
	var parts_to_subtract : Array = [string_to_array(num1), string_to_array(num2)]
	
	if is_less_than(num1, num2):
		negative = true
		parts_to_subtract.invert()
	
	if parts_to_subtract[0].size() > parts_to_subtract[1].size():
		for i in parts_to_subtract[0].size() - parts_to_subtract[1].size():
			parts_to_subtract[1] += PoolIntArray([0])
	elif parts_to_subtract[0].size() < parts_to_subtract[1].size():
		for i in parts_to_subtract[1].size() - parts_to_subtract[0].size():
			parts_to_subtract[0] += PoolIntArray([0])
	
	var result_array : Array
	var subtract_carry_over : int
	result_array.resize(parts_to_subtract[-1].size())
	result_array.fill(0)
	
	for i in max(parts_to_subtract[0].size(), parts_to_subtract[1].size()):
		var partial_result : int
		
		if parts_to_subtract[0][i] < parts_to_subtract[1][i] + subtract_carry_over:
			result_array[i] = 10 - ((parts_to_subtract[1][i] + subtract_carry_over) - parts_to_subtract[0][i])
			subtract_carry_over = 1
		else:
			result_array[i] = parts_to_subtract[0][i] - (parts_to_subtract[1][i] + subtract_carry_over)
			subtract_carry_over = 0
	
	var result : String
	
	for i in result_array.size():
		if i == 0:
			if (negative and !overright_negative) or (!negative and overright_negative):
				result += "-"
		if result_array.size() - i - 1 == decimal_places - 1:
			result += "."
		result += String(result_array[-i - 1])
	
	while result.left(1) == "0":
		result = result.right(1)
	if result.left(1) == ".":
		result = "0" + result
	
	if decimal_places != 0:
		var removed_decimals : int
		while result.right(result.length() - 1) == "0":
			result = result.left(result.length() - 1)
			removed_decimals += 1
			if removed_decimals == decimal_places:
				result = result.left(result.length() - 1)
	
	return result

static func is_less_than(num1 : String = "0", num2 : String = "0"):
	
	var invert : bool
	
	if num1.left(1) == "-" and num2.left(1) == "-":
		num1 = num1.right(1)
		num2 = num2.right(1)
		invert = true
	elif num1.left(1) == "-" and num2.left(1) != "-":
		return true
	elif num1.left(1) != "-" and num2.left(1) == "-":
		return false 
	
	if num1.length() < num2.length(): 
		return true if !invert else false
	elif num1.length() > num2.length(): 
		return false if !invert else true
	else:
		for i in num1.length():
			if int(num1.right(i).left(1)) < int(num2.right(i).left(1)): 
				return true if !invert else false
			elif int(num1.right(i).left(1)) > int(num2.right(i).left(1)): 
				return false if !invert else true
	
	return false if !invert else true

func big_round(number : String = "0"):
	if number.find(".") != -1:
		if int(number.right(number.find(".") + 1).left(1)) >= 5:
			return big_add(number.left(number.find(".")), "1")
		else:
			return number.left(number.find("."))
	else:
		return number

func is_even(num : String = "0"):
	if num.find(".") != -1:
		return false
	for i in ["0", "2", "4", "6", "8"]:
		if num.right(num.length() - 1) == i:
			return true
	return false
