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
var correct_result = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_exercise(exercise: Exercise) -> void:
	parent_exercise = exercise
	verb.text = exercise.verb.eg_script
	prompt.text = exercise.prompt
	
	if exercise.intro.length() > 0:
		var intro = exercise.intro
		var intro_label = CHAR.instantiate()
		chars_ui.add_child(intro_label)		
		intro_label.set_values(intro, SLOT_TYPE.IMMUTABLE)
	
	for i in range(exercise.exercise_template.size()):
		var index = exercise.exercise_template.size() - i - 1
		var char = CHAR.instantiate()	
		chars_ui.add_child(char)		
		var template = exercise.exercise_template[i][0]
		if template == "_":
			# see that the solution is in the same [[], []] list going in here and use that for solution
			char.set_values(exercise.exercise_initial[i][0],  SLOT_TYPE.FILL, exercise.exercise_solution[i][0])
		elif template == "X":
			char.set_values(exercise.exercise_initial[i][0], SLOT_TYPE.REPLACE, exercise.exercise_solution[i][0])
		elif template == "O":
			char.set_values(exercise.exercise_initial[i][0], SLOT_TYPE.IMMUTABLE, exercise.exercise_solution[i][0])
		
		char.connect("drag_finished", _on_letter_drag_finished)
		chars.append(char)
		
	for letter in parent_exercise.exercise_solution:
		correct_result += letter[0]
		
	calculate_resulting_word()

func _on_letter_drag_finished():
	calculate_resulting_word()	

	
func calculate_resulting_word():
	resulting_word = ""
	for char in chars:
		resulting_word += char.label.text
	result.text = parent_exercise.intro + ' ' + resulting_word
	# finish if correct
	if resulting_word == correct_result:
		order_solved.emit(self)
		
		
