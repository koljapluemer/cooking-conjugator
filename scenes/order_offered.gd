extends HBoxContainer

const BLOND_HAIRED_WOMAN = preload("res://assets/people/blond-haired-woman.png")
const BOY = preload("res://assets/people/boy.png")
const GIRL = preload("res://assets/people/girl.png")
const MAN_FACEPALMING = preload("res://assets/people/man-facepalming.png")
const MAN_FROWNING = preload("res://assets/people/man-frowning.png")
const MAN_WEARING_TURBAN = preload("res://assets/people/man-wearing-turban.png")
const MAN_IN_TUXEDO = preload("res://assets/people/man_in_tuxedo.png")
const MAN_WITH_GUA_PI_MAO = preload("res://assets/people/man_with_gua_pi_mao.png")
const MRS_CLAUS = preload("res://assets/people/mrs_claus.png")
const OLDER_WOMAN = preload("res://assets/people/older_woman.png")
const PRINCE = preload("res://assets/people/prince.png")
const PRINCESS = preload("res://assets/people/princess.png")
const WOMAN_POUTING = preload("res://assets/people/woman-pouting.png")
const WOMAN_WEARING_TURBAN = preload("res://assets/people/woman-wearing-turban.png")
const WOMAN = preload("res://assets/people/woman.png")

const PEOPLE = [
	BLOND_HAIRED_WOMAN, BOY, GIRL, MAN_FACEPALMING, MAN_FROWNING, MAN_WEARING_TURBAN, MAN_IN_TUXEDO, MAN_WITH_GUA_PI_MAO, MRS_CLAUS, OLDER_WOMAN, PRINCE, PRINCESS,
	WOMAN_POUTING, WOMAN_WEARING_TURBAN, WOMAN
]
@onready var portrait: TextureRect = %Portrait

var parent_exercise: Exercise
@onready var label: Label = $Label
var person

signal matched_with_fitting_verb(offer)

func set_exercise(exercise: Exercise) -> void:
	parent_exercise = exercise
	label.text = exercise.prompt
	# set random person 
	person = PEOPLE[randi() % PEOPLE.size()]
	portrait.texture = person
	
func _can_drop_data(at_position, data):
	return data == parent_exercise.verb.eg_script
	#return typeof(data) == TYPE_STRING
	
func _drop_data(at_position, data):
	matched_with_fitting_verb.emit(self)
