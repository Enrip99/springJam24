extends Node2D;

onready var icona_avis = $"Icona Avis";
onready var jugador = $"../Jugador";

export var minijoc: PackedScene;
export var tempsTotal: float;
export var tempsLimit: float;

var MJinstancia: Node;
var tempsRestant: float;
var dins: bool;
var canPlay: bool;

signal denyMovement;
signal allowMovement;

func _ready():
# warning-ignore:return_value_discarded
	self.connect("allowMovement", jugador, "_allow_control");
# warning-ignore:return_value_discarded
	self.connect("denyMovement", jugador, "_deny_control");
	tempsRestant = tempsTotal;
	dins = false;
	canPlay = true;

func _process(delta):
	tempsRestant -= delta;
	if (tempsRestant > tempsLimit):
		icona_avis.animation = "None";
	elif (dins):
		icona_avis.animation = "Button";
	else:
		icona_avis.animation = "Clock";

func _on_Area_collisio_body_entered(_body):
	dins = true;

func _input(event):
	if event.is_action_pressed("Enter"):
		if canPlay && dins && tempsRestant < tempsLimit:
			canPlay = false;
			emit_signal("denyMovement");
			MJinstancia = minijoc.instance();
			get_parent().add_child(MJinstancia);
# warning-ignore:return_value_discarded
			MJinstancia.connect("minigame_end", self, "_on_minigame_end");

func _on_minigame_end():
	emit_signal("allowMovement");
	MJinstancia.queue_free();
	tempsRestant = tempsTotal;
	canPlay = true;

func _on_Area_collisio_body_exited(_body):
	dins = false;
