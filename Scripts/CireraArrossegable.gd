extends KinematicBody2D;
onready var escenaPare = $"..";
var dragging = 0;

signal dragsignal;
signal acabat;

func _ready():
	connect("dragsignal",self,"_set_drag_pc");


func _process(delta):
	if dragging == 1:
		position = escenaPare.get_local_mouse_position();


func _set_drag_pc():
	dragging += 1;
	if dragging == 1:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if dragging == 2:
		emit_signal("acabat");
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_StaticBody2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			emit_signal("dragsignal");
