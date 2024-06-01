extends Control

var original_value
var correct_solution
var slot_type
signal drag_finished
@onready var label: Label = $Label

func set_values(text_in, _slot_type, solution = null):
	original_value = text_in
	correct_solution = solution	
	label.text = text_in	
	slot_type = _slot_type
	adapt_theme_to_type()	

func reset_text():
	label.text = original_value

func _can_drop_data(at_position, data):
	# don't allow when the slot is already filled correctly 
	if slot_type == SLOT_TYPE.IMMUTABLE:
		return false
	if typeof(data) == TYPE_STRING:
		return data == correct_solution
	return false
	
func _drop_data(at_position, data):
	slot_type = SLOT_TYPE.IMMUTABLE
	adapt_theme_to_type()
	label.text = data
	drag_finished.emit()

func adapt_theme_to_type():
	if slot_type == SLOT_TYPE.FILL:
		label.theme_type_variation = "LabelBlue"
	if slot_type == SLOT_TYPE.REPLACE:
		label.theme_type_variation = "LabelYellow"
	if slot_type == SLOT_TYPE.IMMUTABLE:
		label.theme_type_variation = ""
