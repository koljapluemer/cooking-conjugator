class_name Exercise

var prompt: String
var base_form: String
var exercise_initial: Array
var exercise_template: Array
var exercise_solution: Array
var exercise_letters: Array
var intro: String

var verb: Verb

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_values(json: Dictionary, parent_verb: Verb) -> void:
	prompt = json["prompt"]
	base_form = json["base_form"]
	exercise_initial = json["exercise_initial"]
	exercise_template = json["exercise_template"]
	exercise_solution = json["exercise_solution"]
	exercise_letters = json["exercise_letters"]
	intro = json["intro"]

	verb = parent_verb
