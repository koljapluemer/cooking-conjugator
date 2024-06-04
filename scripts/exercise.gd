class_name Exercise

var en: String
var eg_franco: String
var eg_script: String
var eg_script_chars: Array
var eg_script_only_verb: String
var eg_script_only_intro: String
var exercise_template: Array
var exercise_initial: Array
var exercise_solution: Array
var removed_letters: Array
var tense: String
var verb: Verb

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_values(json: Dictionary, parent_verb: Verb) -> void:
	en = json["EN"]
	eg_franco = json["EG_transliteration"]
	eg_script = json["EG_script"]
	eg_script_chars = json["EG_chars"]
	eg_script_only_verb = json["EG_only_verb"]
	eg_script_only_intro = json["EG_only_intro"]
	exercise_template = json["exercise_template"]
	exercise_initial = json["exercise"]
	exercise_solution = json["exercise_solution"]
	removed_letters = json["removed_letters"]
	tense = json["tense"]
	verb = parent_verb
