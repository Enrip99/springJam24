extends Node2D
signal minigame_end (score);
onready var gerra = $GerraLlet;
onready var cafe = $"cafe";
var poscafe: Vector2;
var score: int;
var canRise = true;
var canFall = false;
var lletVertida = 0.0;
var cafeInicial = 30.0;
var lletDemanada: float;
export var cabal: float;


func _ready():
	lletDemanada = 10.0 + randf() * 30.0;
	$Fletxa.position = Vector2($Fletxa.position.x, $Fletxa.position.y - (lletDemanada + cafeInicial));
	poscafe = cafe.position;
	cafe.position = poscafe - Vector2(0, cafeInicial + lletVertida);


func _process(delta):
	if canFall:
		lletVertida += delta * cabal;
		if cafeInicial + lletVertida > 110:
			drop();
	cafe.position = poscafe - Vector2(0, cafeInicial + lletVertida);


func _on_CafeAmbLlet_acabat():
	#score = clamp(100 - (abs(lletDemanada - lletVertida) * 20), 0, 100);
	#print(100 - (abs(lletDemanada - lletVertida) * 20), " - " , lletDemanada, " - ", lletVertida)
	var temp = abs (lletDemanada - lletVertida) * 5;
	score = int (max (0, 100 - temp));
	if score > 0:
		$ParticulesFiMinijoc.emitting = true
	emit_signal("minigame_end", score);


func vertir():
	canFall = true;


func drop():
	canFall = false
	var tween = get_tree().create_tween();
	tween.tween_property(gerra, "rotation_degrees", 0.0, .35).set_ease(Tween.EASE_OUT);
	tween.parallel().tween_property(gerra, "position", Vector2(272,9), .35).set_ease(Tween.EASE_OUT);
	tween.tween_callback(self, "_on_CafeAmbLlet_acabat")


func _on_StaticBody_Gerra_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed == true:
		if canRise:
			canRise = false
			var tween = get_tree().create_tween();
			tween.tween_property(gerra, "rotation_degrees", -45.0, .35).set_ease(Tween.EASE_OUT);
			tween.parallel().tween_property(gerra, "position", Vector2(134,-164), .35).set_ease(Tween.EASE_OUT);
			tween.tween_callback(self, "vertir")
		elif canFall:
			drop();
