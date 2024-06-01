extends Control

const EXERCISES_PATH = "res://data/exercises_4.json"
var exercises = []
var verbs = []

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
	print(exercises)

func load_json_file(file_path: String):
	if FileAccess.file_exists(file_path):
		var dataFile = FileAccess.open(file_path, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		return parsedResult
	else:
		print("File does not exist")
