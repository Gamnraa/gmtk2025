extends Node2D
@export_enum("RED", "GREEN", "BLUE", "REDGREEN", "GREENBLUE", "REDBLUE", "REDGREENBLUE", "NONE") var color: int = Global.NONE

func _ready():
	get_child(0).color = color
