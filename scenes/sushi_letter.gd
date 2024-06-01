extends CenterContainer
@onready var label: Label = $Label
var is_dragging = false

var movement_tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x += 20.0 * delta

func _get_drag_data(at_position):
	var preview = label.duplicate()
	set_drag_preview(preview)
	visible = false	
	is_dragging = true
	return label.text
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END and not get_viewport().gui_is_drag_successful():
		reset()
	
func reset():
	visible = true
