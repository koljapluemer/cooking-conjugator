extends HBoxContainer

var parent_exercise: Exercise

signal order_solved(order)

@onready var prompt: Label = $VBoxContainer/HBoxContainer/Prompt
@onready var verb: Label = $VBoxContainer/HBoxContainer/Verb
@onready var result: Label = $VBoxContainer/ResultBox/Result


@onready var chars_ui: HBoxContainer = $VBoxContainer/Chars
const CHAR = preload("res://scenes/char.tscn")
var chars = []
var resulting_word = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_exercise(exercise: Exercise) -> void:
	parent_exercise = exercise
	verb.text = exercise.verb.eg_script
	prompt.text = exercise.en
	
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
		
		char.connect("drag_finished", _on_letter_drag_finished)
		chars.append(char)
		
	calculate_resulting_word()

func _on_letter_drag_finished():
	calculate_resulting_word()	
	if resulting_word == parent_exercise.eg_script_only_verb:
		order_solved.emit(self)
	
func calculate_resulting_word():
	resulting_word = ""
	for char in chars:
		resulting_word += char.label.text
	result.text = parent_exercise.eg_script_only_intro + resulting_word
	
		
		
