extends CharacterBody2D
var max_speed = 150
var ground_speed = 244
var air_speed = 270
var accel = 21
var jump_force = 572.4

var coyote_timer = 5
var coyote_timer_max = 5

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
		velocity += get_gravity() * 0.037
		
	if !is_on_floor() and coyote_timer > 0:
		coyote_timer -= 1
	if is_on_floor():
		coyote_timer = coyote_timer_max
		
	if Input.is_action_pressed("right"):
		
		velocity.x = min(velocity.x + accel, max_speed)
		$Sprite2D.flip_h = false
		if is_on_floor(): $Sprite2D/AnimationPlayer.play("player-walk")
		
	if Input.is_action_pressed("left"):
		velocity.x = max(velocity.x - accel, -max_speed)
		$Sprite2D.flip_h = true
		if is_on_floor(): $Sprite2D/AnimationPlayer.play("player-walk")
		
	if (grounded or coyote_timer > 0) and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_force
		if velocity.x > 0: velocity.x += 350
		if velocity.x < 0: velocity.x -= 350
		
	if not(Input.is_action_pressed("left") or Input.is_action_pressed("right")) and grounded:
		velocity.x = move_toward(velocity.x, 0, accel)
		$Sprite2D/AnimationPlayer.play("player-idle")
		
	if not was_grounded and grounded: velocity.x = max(velocity.x - (accel * 5.13), 0)
	was_grounded = grounded
	move_and_slide()
