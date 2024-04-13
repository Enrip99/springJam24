extends KinematicBody2D;
onready var sprite = $SpriteJugador;
var direccio: Vector2;
var canMove: bool;
export var velocitat: float;

func _ready():
	canMove = true;


func _allow_control():
	canMove = true;


func _deny_control():
	canMove = false;


func _process(_delta):
	if direccio.x > 0:
		sprite.flip_h  = true;
	elif direccio.x < 0:
		sprite.flip_h = false;
	if direccio.length() > 0:
		sprite.animation = "Walk";
	else:
		sprite.animation = "Idle";


func _physics_process(_delta):
	if canMove:
		direccio = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown");
# warning-ignore:return_value_discarded
		move_and_collide(direccio * velocitat);

