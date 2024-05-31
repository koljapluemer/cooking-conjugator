class_name DragSlot extends Button

var original_value = "X"

signal drag_finished

func _init() -> void:
	set_values("A", SLOT_TYPE.FILL)
	pass

func set_values(text_in,  slot_type):
	print("setting values")
	if slot_type == SLOT_TYPE.FILL:
		modulate = Color.CADET_BLUE
	if slot_type == SLOT_TYPE.REPLACE:
		modulate = Color.DARK_SLATE_GRAY
	else:
		modulate = Color.DARK_SLATE_BLUE		
	original_value = text_in	
	text = text_in		

func reset_text():
	text = original_value

func _can_drop_data(at_position, data):
	# check if data is string
	return typeof(data) == TYPE_STRING
	
func _drop_data(at_position, data):
	text = data
	drag_finished.emit()

