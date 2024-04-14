extends Node2D
onready var brac = $"Braç";
signal minigame_end (score);
var score = 100;
var llibreEnMa = 0;
var ordre = [];
var slots = [];


func on_Llibreria_acabat():
	$ParticulesFiMinijoc.emitting = true
	emit_signal("minigame_end", score);


func _on_Llibre_input_event(_viewport, event, _shape_idx, slotID):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed == true:
		if llibreEnMa == 0 && ordre[slotID] != 0:
			llibreEnMa = ordre[slotID];
			brac.frame = llibreEnMa;
			ordre[slotID] = 0;
			slots[slotID].get_child(0).frame = 0;
		elif llibreEnMa != 0 && ordre[slotID] == 0:
			ordre[slotID] = llibreEnMa;
			slots[slotID].get_child(0).frame = llibreEnMa;
			llibreEnMa = 0;
			brac.frame = llibreEnMa;
			if (score > 5): score -= 5;
			if check_ordenat(): on_Llibreria_acabat()


func check_ordenat() -> bool:
	var ordreCopy = ordre.duplicate();
	if ordreCopy[0] == 0: ordreCopy.pop_front();
	elif ordreCopy[-1] == 0: ordreCopy.pop_back();
	
	for i in ordreCopy.size():
		if i+1 != ordreCopy[i]: return false;
	return true;


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);
	slots = $Prestatge.get_children();
	for i in slots.size():
		ordre.append(i);
	while check_ordenat():
		ordre.shuffle();
	for i in ordre.size():
		slots[i].get_child(0).frame = ordre[i];


func _process(_delta):
	brac.position = get_local_mouse_position();
