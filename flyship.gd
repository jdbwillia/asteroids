extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var screen_size
var accel
var shipVelocity = Vector2(0,0)

const THRUST_SPEED = 100
const ROTATE_SPEED = 2
const ACCEL_RATE = 0.01
const MAX_VELOCITY = 100

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	screen_size = get_viewport_rect().size
	get_node("ship").set_pos(Vector2(screen_size.x/2, screen_size.y/2))
	accel = 0
	set_process(true)

func _process(delta):
	var ship_pos = get_node("ship").get_pos()
	
	get_node("Rotation").set_text(str(get_node("ship").get_rot()));
	
	#determine velocity vector
	if (Input.is_action_pressed("ship_forward")) :
		#velocity only changes when thrust is being applied
		if (accel < 1.0) :
			accel += ACCEL_RATE
		
		shipVelocity.x += -sin(get_node("ship").get_rot()) * THRUST_SPEED * delta * accel
		shipVelocity.y += -cos(get_node("ship").get_rot()) * THRUST_SPEED * delta * accel
		#shipVelocity.x = min(shipVelocity.x, MAX_VELOCITY)
		#shipVelocity.y = min(shipVelocity.y, MAX_VELOCITY)
	else :
		accel = 0
	
	#apply thrust
	ship_pos += shipVelocity
	
	#wrap around scren if necessary
	if (ship_pos.x > screen_size.x) :
		ship_pos.x = ship_pos.x - screen_size.x
	if (ship_pos.x < 0) :
		ship_pos.x = screen_size.x + ship_pos.x
	if (ship_pos.y > screen_size.y) :
		ship_pos.y = ship_pos.y - screen_size.y
	if (ship_pos.y < 0) :
		ship_pos.y = screen_size.y + ship_pos.y
	get_node("ship").set_pos(ship_pos)
	
	#rotate cw
	if (Input.is_action_pressed("ship_cw")) :
		get_node("ship").set_rot(get_node("ship").get_rot() + (ROTATE_SPEED * delta))
	
	#rotate ccw
	if (Input.is_action_pressed("ship_ccw")) :
		get_node("ship").set_rot(get_node("ship").get_rot() - (ROTATE_SPEED * delta))
