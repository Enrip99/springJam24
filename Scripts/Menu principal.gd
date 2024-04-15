extends Control

func _ready():
	if GlobalVars.bestScore != 0: $MillorPuntuacio.set_text("Record:\n%s punts" % GlobalVars.bestScore);
	else: $MillorPuntuacio.set_text("");

func _on_Bot_Jugar_pressed():
	get_tree().change_scene("res://Escenes/Hub.tscn");


func _on_Bot_Sortir_pressed():
	get_tree().quit();
