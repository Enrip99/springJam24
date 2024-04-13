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
signal addScore;


func _ready():
# warning-ignore:return_value_discarded
	self.connect("allowMovement", jugador, "_allow_control");
# warning-ignore:return_value_discarded
	self.connect("denyMovement", jugador, "_deny_control");
# warning-ignore:return_value_discarded
	self.connect("addScore", $"..", "_addScore");
	$"..".minigameList.append(self);
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


func _input(event):
	if event.is_action_pressed("Enter"):
		if canPlay && dins && tempsRestant < tempsLimit:
			canPlay = false;
			emit_signal("denyMovement");
			MJinstancia = minijoc.instance();
			get_parent().add_child(MJinstancia);
			MJinstancia.scale = Vector2(0,0);
			MJinstancia.position = position;
# warning-ignore:return_value_discarded
			MJinstancia.connect("minigame_end", self, "_on_minigame_end");
			var tweenScale = get_tree().create_tween();
			var tweenPos = get_tree().create_tween();
			tweenScale.tween_property(MJinstancia, "scale", Vector2(1,1), .35).set_ease(Tween.EASE_OUT);
			tweenPos.tween_property(MJinstancia, "position", Vector2(512,300), .35).set_ease(Tween.EASE_OUT);


func _on_minigame_end(score):
	emit_signal("addScore", score);
	emit_signal("allowMovement");
	tempsRestant = tempsTotal;
	canPlay = true;
	var tweenClose = get_tree().create_tween();
	tweenClose.tween_property(MJinstancia, "scale", Vector2(1,1), 1.5).set_ease(Tween.EASE_OUT);
	tweenClose.tween_property(MJinstancia, "scale", Vector2(), .35).set_ease(Tween.EASE_OUT);
	tweenClose.tween_callback(MJinstancia, "queue_free")


func _on_Area_collisio_body_entered(_body):
	dins = true;


func _on_Area_collisio_body_exited(_body):
	dins = false;
