extends CenterContainer
@onready var label: Label = $Label

var movement_tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	movement_tween = create_tween()
	# move to the right of the screen
	movement_tween.tween_property(self, "position:x", get_viewport_rect().size.x, 12)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _get_drag_data(at_position):
	var preview = duplicate()
	set_drag_preview(preview)
	visible = false	
	return label.text
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END and not get_viewport().gui_is_drag_successful():
		reset()
	
func reset():
	visible = true
