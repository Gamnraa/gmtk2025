extends StaticBody2D
@export_enum("RED", "GREEN", "BLUE", "REDGREEN", "GREENBLUE", "REDBLUE", "REDGREENBLUE", "NONE") var color: int = Global.NONE
var valid_colors = [
	[Global.RED],
	[Global.GREEN],
	[Global.BLUE],
	[Global.RED, Global.GREEN],
	[Global.GREEN, Global.BLUE],
	[Global.RED, Global.BLUE],
	[Global.RED, Global.GREEN, Global.BLUE],
	[]
	]


func init_hidden():
	self.visible = false
	$CollisionShape2D.disabled = true

func init_visible():
	self.visible = true
	$CollisionShape2D.disabled = false
	
func appear():
	$AnimationPlayer.play("Appear")
	
func disappear():
	$AnimationPlayer.play_backwards("Appear")

func _ready():
	if color == Global.NONE: init_visible()
	else: 
		init_hidden()
		var is_shader_color = (color == Global.RED or 
			color == Global.REDGREEN or 
			color == Global.REDBLUE or 
			color == Global.REDGREENBLUE)
			
		print(is_shader_color)
		$Sprite2D.material.set_shader_parameter("red", is_shader_color)
		is_shader_color = (color == Global.GREEN or 
			color == Global.REDGREEN or 
			color == Global.GREENBLUE or 
			color == Global.REDGREENBLUE)
		
		$Sprite2D.material.set_shader_parameter("green", is_shader_color)
		is_shader_color = (color == Global.BLUE or 
			color == Global.REDBLUE or 
			color == Global.GREENBLUE or 
			color == Global.REDGREENBLUE)
			
		$Sprite2D.material.set_shader_parameter("blue", is_shader_color)
		
	if Global.State != Global.NONE and color == Global.State:
		appear()

func _process(delta): 
	if color == Global.NONE: return
	if self.visible and color not in valid_colors[Global.State]: disappear()
	if not self.visible and color in valid_colors[Global.State]: appear()
