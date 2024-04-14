extends Node2D;

onready var icona_avis = $"Icona Avis";
onready var jugador = $"../Jugador";

export var minijoc: PackedScene;

var MJinstancia: Node;
var dins: bool;
var canPlay: bool;
var jugant = false;

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
	dins = false;
	#canPlay = true;


func _process(_delta):
	if (dins && canPlay):
		icona_avis.animation = "Button";
	elif (!dins && canPlay):
		icona_avis.animation = "Clock";
	else:
		icona_avis.animation = "None";


func _input(event):
	if event.is_action_pressed("Enter"):
		if canPlay && dins:
			canPlay = false;
			jugant = true;
			emit_signal("denyMovement");
			MJinstancia = minijoc.instance();
			get_parent().add_child(MJinstancia);
			MJinstancia.scale = Vector2(0,0);
			MJinstancia.position = position;
			MJinstancia.z_index = 4;
# warning-ignore:return_value_discarded
			MJinstancia.connect("minigame_end", self, "_on_minigame_end");
			var tweenScale = get_tree().create_tween();
			var tweenPos = get_tree().create_tween();
			tweenScale.tween_property(MJinstancia, "scale", Vector2(1,1), .35).set_ease(Tween.EASE_OUT);
			tweenPos.tween_property(MJinstancia, "position", Vector2(512,300), .35).set_ease(Tween.EASE_OUT);


func _on_minigame_end(score):
	emit_signal("addScore", score);
	var tweenClose = get_tree().create_tween();
	tweenClose.tween_property(MJinstancia, "scale", Vector2(1,1), 1.5).set_ease(Tween.EASE_OUT);
	tweenClose.tween_property(MJinstancia, "scale", Vector2(), .35).set_ease(Tween.EASE_OUT);
	tweenClose.tween_callback(self, "allibera");
	tweenClose.tween_callback(MJinstancia, "queue_free")


func allibera():
	jugant = false;
	emit_signal("allowMovement");
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);


func _on_Area_collisio_body_entered(_body):
	dins = true;


func _on_Area_collisio_body_exited(_body):
	dins = false;
