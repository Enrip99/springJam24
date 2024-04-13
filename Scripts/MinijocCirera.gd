extends Node2D

signal minigame_end (score);
var dins = false;
var score = 0;


func _on_Cirera_acabat():
	if dins:
		score = max(10, int(100 - $Cirera.position.distance_to($Area2D.position)/2));
		$ParticulesFiMinijoc.emitting = true
	emit_signal("minigame_end", score);


func _on_Area2D_body_entered(_body):
	dins = true;


func _on_Area2D_body_exited(_body):
	dins = false
