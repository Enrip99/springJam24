extends Control


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	var toprint = "%s punts" % GlobalVars.lastscore;
	if (GlobalVars.lastscore == GlobalVars.bestScore): toprint += " - RECORD!";
	$VBoxContainer/Label.set_text(toprint);


func _on_Button_pressed():
	get_tree().change_scene("res://Escenes/Menu principal.tscn");
