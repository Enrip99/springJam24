extends Node
onready var textePuntuacio = $Marcador;
onready var texteVides = $Vides;
const placeholderPunts = "Punts: ";
const placeholderVides = "Vides: ";
var minigameList = [];
var totalscore = 0;
var vides: int;
export var videsInicials: int = 5;
var temporitzador: float;
var randomClass;


func _addScore(score):
	if score == 0:
		vides -= 1;
		texteVides.text = placeholderVides + String(vides);
		if vides == 0:
			GlobalVars.set_score(totalscore);
			get_tree().change_scene("res://Escenes/Fi del joc.tscn");
	else:
		totalscore += score;
		textePuntuacio.text = placeholderPunts + String(String(totalscore)).pad_zeros(4);


func fer_jugable():
	var escollit = randi()%minigameList.size();
	if !minigameList[escollit].jugant:
		minigameList[escollit].canPlay = true;
	temporitzador = randomClass.randfn(6,2);


func _ready():
	vides = videsInicials;
	textePuntuacio.text = placeholderPunts + String(String(totalscore)).pad_zeros(4);
	texteVides.text = placeholderVides + String(vides);
	randomClass = RandomNumberGenerator.new();
	randomClass.randomize();
	randomize();
	fer_jugable();


func _process(delta):
	temporitzador -= delta;
	if temporitzador <= 0:
		fer_jugable();
