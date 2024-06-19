extends Control

const UI = preload("res://scenes/main_ui.tscn")

@onready var instruction_label_1: Label = $VBoxContainer/MarginContainer/Instructions/InstructionLabel1
@onready var instruction_label_2: Label = $VBoxContainer/MarginContainer/Instructions/InstructionLabel2
@export var is_tutorial:bool = false 

@onready var confetti: CPUParticles2D = %Confetti

const KILL_TIMER = preload("res://scenes/kill_timer.tscn")
const EXERCISES_PATH = "res://data/ex-0.json"
var exercises = []
var verbs = []

const SUSHI_WORD = preload("res://scenes/sushi_word.tscn")
@onready var sushi_words: Node2D = $VBoxContainer/Belts/SushiWords

const SUSHI_LETTER = preload("res://scenes/sushi_letter.tscn")
@onready var sushi_letters: Node2D = $VBoxContainer/Belts/SushiLetters

const ORDER_OFFERED = preload("res://scenes/order_offered.tscn")
@onready var orders_offered_ui: VBoxContainer = $VBoxContainer/OrdersOffered
var orders_offered_list = []

const ORDER_TAKEN = preload("res://scenes/order_taken.tscn")
@onready var workspace_ui: VBoxContainer = $VBoxContainer/Workspace
var orders_taken_list = []
var order_finished_list = []
var nr_of_orders_on_screen = 0

var letter_pool = []
var verb_pool = []

const ALPHABET = [
	'ا', 'ب', 'ت', 'ث', 'ج', 'ح', 'خ', 'د', 'ذ', 'ر', 'ز', 
	'س', 'ش', 'ص', 'ض', 'ط', 'ظ', 'ع', 'غ', 'ف', 'ق', 
	'ك', 'ل', 'م', 'ن', 'ه', 'و', 'ي'
]


func _ready() -> void:
	var raw_exercise_list = load_json_file(EXERCISES_PATH)
	# loop exercises and create Exercise objects
	for exercise in raw_exercise_list:
		# check if Verb object exist, otherwise create based on
		# verb_EN and verb_EG_script
		
		var verb: Verb
		# if no verb with en == exercise["base_form"] in verbs"
		if not verbs.has(exercise["base_form"]):
			verb = Verb.new(exercise["base_form"])
			verbs.append(verb)
		else:
			verb = verbs[exercise["base_form"]]


		var new_exercise = Exercise.new()
		new_exercise.set_values(exercise, verb)
		exercises.append(new_exercise)

	generate_random_order()
	add_random_sushi_word_from_pool()

func load_json_file(file_path: String):
	if FileAccess.file_exists(file_path):
		var dataFile = FileAccess.open(file_path, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		return parsedResult
	else:
		print("File does not exist")

func add_sushi_word(verb: Verb) -> void:
	var sushi_word = SUSHI_WORD.instantiate()
	sushi_word.text = verb.eg_script
	sushi_word.verb = verb
	sushi_words.add_child(sushi_word)
	sushi_word.position.x -= sushi_word.size.x 

func add_sushi_letter(letter: String = "A") -> void:
	var sushi_letter = SUSHI_LETTER.instantiate()
	# move to the left by own width
	sushi_letters.add_child(sushi_letter)
	sushi_letter.position.x -= sushi_letter.size.x	
	# with 25% chance, use a random letter from ALPHABET instead

	if randf() < 0.25 and not is_tutorial:
		sushi_letter.label.text = ALPHABET[randi() % ALPHABET.size()]
	else:
		sushi_letter.label.text = letter



func add_random_sushi_letter_from_pool() -> void:
	if letter_pool.size() > 0:
		var random_letter = letter_pool[randi() % letter_pool.size()]
		add_sushi_letter(random_letter)

func add_random_sushi_word_from_pool() -> void:
	if verb_pool.size() > 0:
		var random_verb = verb_pool[randi() % verb_pool.size()]
		add_sushi_word(random_verb)

func fill_up_orders():
	if nr_of_orders_on_screen < 4 and not is_tutorial or nr_of_orders_on_screen < 1 and is_tutorial:
		generate_random_order()

func generate_random_order() -> void:
	var random_exercise = exercises[randi() % exercises.size()]
	var order_offered = ORDER_OFFERED.instantiate()
	orders_offered_ui.add_child(order_offered)
	order_offered.set_exercise(random_exercise)
	orders_offered_list.append(order_offered)
	nr_of_orders_on_screen += 1
	
	order_offered.connect("matched_with_fitting_verb", _on_order_matched_with_fitting_verb)
	verb_pool.append(random_exercise.verb)
	
func _on_order_matched_with_fitting_verb(order):
	move_order_to_workspace(order)
 
func move_order_to_workspace(order) -> void:
	# handle missing letters
	for letter in order.parent_exercise.exercise_letters:
		letter_pool.append(letter)
	
	verb_pool.erase(order.parent_exercise.verb)
	
	orders_offered_list.erase(order)
	orders_taken_list.append(order)
	orders_offered_ui.remove_child(order)
	var order_taken = ORDER_TAKEN.instantiate()
	workspace_ui.add_child(order_taken)
	order_taken.set_exercise(order.parent_exercise)
	order.queue_free()
	order_taken.connect("order_solved", _on_order_solved)
	
	if is_tutorial:
		instruction_label_1.visible = false
		instruction_label_2.visible = true



func _on_order_solved(order) -> void:
	confetti.global_position.x = order.global_position.x + order.size.x / 2
	confetti.global_position.y = order.global_position.y + order.size.y / 2
	confetti.emitting = true

	# start KILL_TIMER and on timeout delete the order etc
	var kill_timer = KILL_TIMER.instantiate()
	var kill_timer_callable = Callable(self, "remove_order").bind(order)
	kill_timer.timeout.connect(kill_timer_callable)
	add_child(kill_timer)
	

func remove_order(order) -> void:
	orders_taken_list.erase(order)
	for letter in order.parent_exercise.exercise_letters:
		letter_pool.erase(letter)
	order.queue_free()
	nr_of_orders_on_screen -= 1
	
	if is_tutorial:
		get_tree().change_scene_to_packed(UI)


func _on_sushi_words_timer_timeout() -> void:
	add_random_sushi_word_from_pool()	

func _on_sushi_letter_timer_timeout() -> void:
	add_random_sushi_letter_from_pool()

func _on_order_timer_timeout() -> void:
	fill_up_orders()
