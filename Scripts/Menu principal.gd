extends Control


func _on_Bot_Jugar_pressed():
	get_tree().change_scene("res://Escenes/Hub.tscn");


func _on_Bot_Sortir_pressed():
	get_tree().quit()
