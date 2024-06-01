extends Control

const EXERCISES_PATH = "res://data/exercises_5.json"
var exercises = []
var verbs = []

const SUSHI_WORD = preload("res://scenes/sushi_word.tscn")
@onready var sushi_words: HBoxContainer = $VBoxContainer/Belts/SushiWords

const SUSHI_LETTER = preload("res://scenes/sushi_letter.tscn")
@onready var sushi_letters: HBoxContainer = $VBoxContainer/Belts/SushiLetters

const ORDER_OFFERED = preload("res://scenes/order_offered.tscn")
@onready var orders_offered_ui: VBoxContainer = $VBoxContainer/OrdersOffered
var orders_offered_list = []

const ORDER_TAKEN = preload("res://scenes/order_taken.tscn")
@onready var workspace_ui: VBoxContainer = $VBoxContainer/Workspace
var orders_taken_list = []
var order_finished_list = []


func _ready() -> void:
	var raw_exercise_list = load_json_file(EXERCISES_PATH)
	# loop exercises and create Exercise objects
	for exercise in raw_exercise_list:
		# check if Verb object exist!!!!!!!!!!!, otherwise create based on
		# verb_EN and verb_EG_script
		
		var verb: Verb
		# if no verb with en == exercise["verb_EN"] in verbs"
		if not verbs.has(exercise["verb_EN"]):
			verb = Verb.new(exercise["verb_EN"], exercise["verb_EG_script"])
			verbs.append(verb)
		else:
			verb = verbs[exercise["verb_EN"]]


		var new_exercise = Exercise.new()
		new_exercise.set_values(exercise, verb)
		exercises.append(new_exercise)


	# generate_random_sushi_words(3)
	generate_random_order()
	generate_random_order()
	generate_random_order()
	generate_random_order()
	move_order_to_workspace(orders_offered_list[0])
	move_order_to_workspace(orders_offered_list[0])
	move_order_to_workspace(orders_offered_list[0])

func load_json_file(file_path: String):
	if FileAccess.file_exists(file_path):
		var dataFile = FileAccess.open(file_path, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		return parsedResult
	else:
		print("File does not exist")


func generate_random_sushi_words(nr_of_words: int) -> void:
	for i in range(nr_of_words):
		var random_verb = verbs[randi() % verbs.size()]
		add_sushi_word(random_verb)


func add_sushi_word(verb: Verb) -> void:
	var sushi_word = SUSHI_WORD.instantiate()
	sushi_word.text = verb.eg_script
	sushi_word.verb = verb
	sushi_words.add_child(sushi_word)


func add_sushi_letter(letter: String = "A") -> void:
	var sushi_letter = SUSHI_LETTER.instantiate()
	sushi_letter.text = letter
	sushi_letters.add_child(sushi_letter)


func generate_random_order() -> void:
	var random_exercise = exercises[randi() % exercises.size()]
	var order_offered = ORDER_OFFERED.instantiate()
	orders_offered_ui.add_child(order_offered)
	order_offered.set_exercise(random_exercise)
	orders_offered_list.append(order_offered)
	
	order_offered.connect("matched_with_fitting_verb", _on_order_matched_with_fitting_verb)
	add_sushi_word(random_exercise.verb)
	
func _on_order_matched_with_fitting_verb(order):
	move_order_to_workspace(order)
 
func move_order_to_workspace(order) -> void:
	# handle missing letters
	for removed_letter in order.parent_exercise.removed_letters:
		add_sushi_letter(removed_letter)
	
	orders_offered_list.erase(order)
	orders_offered_ui.remove_child(order)
	var order_taken = ORDER_TAKEN.instantiate()
	workspace_ui.add_child(order_taken)
	order_taken.set_exercise(order.parent_exercise)
	order.queue_free()
	order_taken.connect("order_solved", _on_order_solved)


func _on_order_solved(order) -> void:
	orders_taken_list.erase(order)
	order.queue_free()
	generate_random_order()
