extends Node
onready var textePuntuacio = $Marcador;
onready var texteVides = $Vides;
const placeholderPunts = "Punts: ";
const placeholderVides = "Vides: ";
var minigameList = [];
var totalscore = 0;
var vides: int;
export var videsInicials: int = 5

func _addScore(score):
	if score == 0:
		vides -= 1;
		texteVides.text = placeholderVides + String(vides);
		if vides == 0:
			pass
			#game over!
	else:
		totalscore += score;
		textePuntuacio.text = placeholderPunts + String(String(totalscore)).pad_zeros(4);


func _ready():
	vides = videsInicials;
	textePuntuacio.text = placeholderPunts + String(String(totalscore)).pad_zeros(4);
	texteVides.text = placeholderVides + String(vides);


#func _process(delta):
#	pass
