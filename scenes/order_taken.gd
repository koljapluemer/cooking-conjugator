extends HBoxContainer

var parent_exercise: Exercise

@onready var en_ui: Label = $VBoxContainer/En

@onready var chars_ui: HBoxContainer = $VBoxContainer/Chars
const CHAR = preload("res://scenes/char.tscn")
var chars = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_exercise(exercise: Exercise) -> void:
	parent_exercise = exercise
	en_ui.text = exercise.en + ", " + exercise.verb.eg_script
	
	if exercise.eg_script_only_intro.length() > 0:
		var intro = exercise.eg_script_only_intro
		var intro_label = CHAR.instantiate()
		chars_ui.add_child(intro_label)		
		intro_label.set_values(intro, SLOT_TYPE.IMMUTABLE)
	
	for i in range(exercise.exercise_template.size()):
		var index = exercise.exercise_template.size() - i - 1
		var char = CHAR.instantiate()	
		chars_ui.add_child(char)		
		var text_val = exercise.exercise_template[index][0]
		if text_val == "_":
			char.set_values("",  SLOT_TYPE.FILL, exercise.eg_script_chars[i])
		elif text_val == "X":
			char.set_values(exercise.exercise_initial[i][0], SLOT_TYPE.REPLACE, exercise.eg_script_chars[i])
		else: 
			char.set_values(exercise.exercise_template[index][0], SLOT_TYPE.IMMUTABLE)

		chars.append(char)
		
#func _can_drop_data(at_position, data):
	#print("received offer for parent")
	#return true
		#
		#
		#
		#
		
		
