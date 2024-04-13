extends Node2D
onready var escenaPare = $"..";
func _process(delta):
	position = escenaPare.get_local_mouse_position();
	if Input.is_mouse_button_pressed( 1 ):
		$SpriteMa.frame = 0;
	else:
		$SpriteMa.frame = 1;
