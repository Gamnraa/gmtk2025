extends CharacterBody2D
var max_speed = 150
var ground_speed = 220
var air_speed = 270
var accel = 22

var activated = true
var was_grounded = true

var start_pos = Vector2(0, 0)


func _ready():
	start_pos = position
	
func _physics_process(delta: float):
	var grounded = is_on_floor()
	
	max_speed = ground_speed
	if not grounded:
		max_speed = air_speed
		velocity += get_gravity() * 0.034
	
	if grounded and Input.is_action_just_pressed("jump"):
		velocity.y = -air_speed * 2
		
	if Input.is_action_pressed("right"):
		
		velocity.x = min(velocity.x + accel, max_speed)
		
	if Input.is_action_pressed("left"):
		velocity.x = max(velocity.x - accel, -max_speed)
		
	if not(Input.is_action_pressed("left") or Input.is_action_pressed("right")) and grounded:
		velocity.x = move_toward(velocity.x, 0, accel)
		
	print(velocity.x)
	if not was_grounded and grounded: velocity.x = max(velocity.x - (accel * 6.7), 0)
	was_grounded = grounded
	move_and_slide()
