class_name DragSlot extends Control

@export var BTN_LABEL: Control
@export var SLOT_PANEL: Control

var original_value = "X"
var btn_label
var btn_panel

signal drag_finished

func _init() -> void:
	pass

func set_values(text, parent, slot_type):
	if slot_type == SLOT_TYPE.FILL:
		btn_panel.color = Color.CADET_BLUE
	if slot_type == SLOT_TYPE.REPLACE:
		btn_panel.color = Color.DARK_SLATE_GRAY
	else:
		btn_panel.color = Color.DARK_SLATE_BLUE		
	original_value = text	
	btn_label.text = text		

func reset_text():
	btn_label.text = original_value

func _can_drop_data(at_position, data):
	# check if data is string
	return typeof(data) == TYPE_STRING
	
func _drop_data(at_position, data):
	btn_label.text = data
	drag_finished.emit()

