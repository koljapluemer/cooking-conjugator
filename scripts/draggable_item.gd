class_name DragItem extends Button

#@export var BTN_LABEL: Controlr
#@export var SLOT_PANEL: Control

var original_value

func _init():
	set_values("U")
	pass

func set_values(text_in):
	text = text_in
	original_value = text_in

func _get_drag_data(at_position):
	#var preview_label = Label.new()
	#preview_label.text = btn_label.text
	
	var preview = duplicate()
	
	set_drag_preview(preview)
	#btn_label.text = ""
	visible = false	
	
	return original_value
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END and not get_viewport().gui_is_drag_successful():
		print("resetting...")
		# drag failed, show label again
		reset()
	
func reset():
	visible = true
