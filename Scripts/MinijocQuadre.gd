extends Node2D
onready var ma = $Ma;
onready var quadre = $Quadre;
onready var maQuadre = $"Quadre/BraçSostenint";
signal minigame_end (score);
var randomClass;
export var velocitat: float;
var score = 0;
var holding = false;
var lastXpos;
var currentXpos;
var canHold = true;


func on_Quadre_acabat():
	var temp = abs (quadre.rotation_degrees) * 50;
	score = int (max (0, 100 - temp));
	if score > 0:
		$ParticulesFiMinijoc.emitting = true
	emit_signal("minigame_end", score);


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);
	randomClass = RandomNumberGenerator.new();
	randomClass.randomize();
	randomize();
	var angle = randomClass.randfn(7,2);
	if randi()%2: angle *= -1;
	quadre.rotation_degrees = angle;
	maQuadre.visible = false;


func _process(_delta):
	if !holding:
		ma.position = get_local_mouse_position();
	else:
		lastXpos = currentXpos;
		currentXpos = get_local_mouse_position().x;
		quadre.rotation_degrees -= (currentXpos - lastXpos) * velocitat;


func _on_KinematicBody2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed && canHold:
		canHold = false;
		holding = true;
		ma.visible = false;
		maQuadre.visible = true;
		maQuadre.position.x = quadre.get_local_mouse_position().x;
		currentXpos = get_local_mouse_position().x


func _input(event):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT && !event.pressed && holding:
		holding = false;
		ma.visible = true;
		maQuadre.visible = false;
		get_viewport().warp_mouse(maQuadre.global_position);
		on_Quadre_acabat()
