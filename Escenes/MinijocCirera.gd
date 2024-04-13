extends Node2D

signal minigame_end;

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("MoveUp"):
		emit_signal("minigame_end");
