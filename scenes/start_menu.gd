extends Control
const UI = preload("res://scenes/ui.tscn")
const TUTORIAL = preload("res://scenes/tutorial_ui.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(UI)


func _on_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_packed(TUTORIAL)
