extends KinematicBody2D;
onready var escenaPare = $"..";
var dragging = 0;

signal dragsignal;
signal acabat;

func _ready():
# warning-ignore:return_value_discarded
	connect("dragsignal",self,"_set_drag_pc");
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);


func _process(_delta):
	if dragging == 1:
		position = escenaPare.get_local_mouse_position();


func _set_drag_pc():
	dragging += 1;
	if dragging == 2:
		emit_signal("acabat");


func _on_StaticBody2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			emit_signal("dragsignal");
