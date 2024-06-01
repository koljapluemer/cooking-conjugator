extends Control

var original_value
var correct_solution
signal drag_finished
@onready var label: Label = $Label

func set_values(text_in, slot_type, solution = null):
	if slot_type == SLOT_TYPE.FILL:
		label.theme_type_variation = "LabelBlue"
	if slot_type == SLOT_TYPE.REPLACE:
		label.theme_type_variation = "LabelYellow"
	original_value = text_in
	correct_solution = solution	
	label.text = text_in		

func reset_text():
	label.text = original_value

func _can_drop_data(at_position, data):
	if typeof(data) == TYPE_STRING:
		return data == correct_solution
	return false
	
func _drop_data(at_position, data):
	label.text = data
	label.theme_type_variation = ""
	drag_finished.emit()

