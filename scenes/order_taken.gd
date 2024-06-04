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
		var template = exercise.exercise_template[index][0]
		if template == "_":
			# see that the solution is in the same [[], []] list going in here and use that for solution
			char.set_values(exercise.exercise_initial[index][0],  SLOT_TYPE.FILL, exercise.exercise_solution[index][0])
		elif template == "X":
			char.set_values(exercise.exercise_initial[index][0], SLOT_TYPE.REPLACE, exercise.exercise_solution[index][0])
		elif template == "O":
			char.set_values(exercise.exercise_initial[index][0], SLOT_TYPE.IMMUTABLE, exercise.exercise_solution[index][0])
		
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
	
		
		
