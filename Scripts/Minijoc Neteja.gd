extends Node2D

signal minigame_end (score);
var randomClass;
var score = 50;
var num_taques: int;
var taques_netejades = 0;
onready var ma = $MaAmbMocador;


func on_Neteja_acabat():
	$ParticulesFiMinijoc.emitting = true
	emit_signal("minigame_end", score);


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);
	num_taques = $Taques.get_child_count();
	print(num_taques)


func _process(_delta):
	ma.position = get_local_mouse_position();


func _on_Taca_cleaned():
	taques_netejades += 1;
	if taques_netejades == num_taques: on_Neteja_acabat();
