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
	
	var intro = exercise.eg_script_only_intro
	print("intro", intro)
	var intro_label = CHAR.instantiate()
	intro_label.set_values(intro, SLOT_TYPE.IMMUTABLE)
	chars_ui.add_child(intro_label)
	
	for i in range(exercise.exercise_template.size()):
		var index = exercise.exercise_template.size() - i - 1
		print("i is", i, "index is", index)
		var char = CHAR.instantiate()	
		var text_val = exercise.exercise_template[index][0]
		if text_val == "_":
			char.set_values("",  SLOT_TYPE.FILL)
		elif text_val == "X":
			char.set_values(exercise.eg_script_chars[index], SLOT_TYPE.REPLACE)
		else: 
			char.set_values(text_val, SLOT_TYPE.IMMUTABLE)
			
		chars_ui.add_child(char)
		chars.append(char)
		
		
		
		
		
		
