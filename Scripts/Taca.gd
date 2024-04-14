extends Sprite
var dins = false;
signal cleaned;
var lastMouseSpeed = Vector2();
var currentMouseSpeed = Vector2();
var actualMouseSpeed = Vector2();

func _ready():
	position = Vector2(randi()%280-100, randi()%120-120);


func _process(delta):
	lastMouseSpeed.x = currentMouseSpeed.x;
	lastMouseSpeed.y = currentMouseSpeed.y;
	currentMouseSpeed = Input.get_last_mouse_speed();
	if lastMouseSpeed.x == currentMouseSpeed.x && lastMouseSpeed.y == currentMouseSpeed.y:
		actualMouseSpeed = Vector2();
	else:
		actualMouseSpeed = currentMouseSpeed;
	if dins && scale.x > 0:
		scale -= Vector2(delta,delta) * actualMouseSpeed.length() * 0.005;
		if scale.x < 0:
			scale = Vector2();
			emit_signal("cleaned");
			queue_free();


func _on_Area2D_area_entered(_area):
	dins = true;


func _on_Area2D_area_exited(_area):
	dins = false;
