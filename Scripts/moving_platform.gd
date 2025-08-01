extends PathFollow2D

@export var speed = 0.5

func _process(delta):
	if progress_ratio >= 1.0 or progress_ratio <= 0.0:
		speed = -speed
	
	progress_ratio += delta * speed
