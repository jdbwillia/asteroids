extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var screen_size
var accel
const THRUST_SPEED = 100
const ROTATE_SPEED = 2

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	screen_size = get_viewport_rect().size
	set_process(true)

func _process(delta):
	var ship_pos = get_node("ship").get_pos()
	
	get_node("Rotation").set_text(str(get_node("ship").get_rot()));
	
	#thrust
	if (Input.is_action_pressed("ship_forward")) :
		ship_pos.x += -sin(get_node("ship").get_rot()) * THRUST_SPEED * delta
		ship_pos.y += -cos(get_node("ship").get_rot()) * THRUST_SPEED * delta
		get_node("ship").set_pos(ship_pos)
	
	#rotate cw
	if (Input.is_action_pressed("ship_cw")) :
		get_node("ship").set_rot(get_node("ship").get_rot() + (ROTATE_SPEED * delta))
	
	#rotate ccw
	if (Input.is_action_pressed("ship_ccw")) :
		get_node("ship").set_rot(get_node("ship").get_rot() - (ROTATE_SPEED * delta))
