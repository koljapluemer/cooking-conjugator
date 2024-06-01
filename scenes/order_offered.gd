extends HBoxContainer

var parent_exercise: Exercise
@onready var label: Label = $Label

signal matched_with_fitting_verb(offer)

func set_exercise(exercise: Exercise) -> void:
	parent_exercise = exercise
	label.text = exercise.en
	
func _can_drop_data(at_position, data):
	return data == parent_exercise.verb.eg_script
	#return typeof(data) == TYPE_STRING
	
func _drop_data(at_position, data):
	matched_with_fitting_verb.emit(self)
	print("dropped")
