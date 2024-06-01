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
	en_ui.text = exercise.en
	for c in exercise.exercise_template:
		var char = CHAR.instantiate()
		chars_ui.add_child(char)
		char.text = c[0]
		chars.append(char)
