extends Node

var ThePlayer = null
var TheScene = null

enum {RED, GREEN, BLUE, REDGREEN, GREENBLUE, REDBLUE, REDGREENBLUE, NONE}
var State = NONE
var ActiveColors = {"RED":[RED, REDGREEN, REDBLUE, REDGREENBLUE], "GREEN":[GREEN, REDGREEN, GREENBLUE, REDGREENBLUE], "BLUE":[BLUE, GREENBLUE, REDBLUE, REDGREENBLUE]}

var level = 0
var sublevel = 0

var levels = [
	["1-1.tscn", "1-2.tscn", "1-3.tscn", "1-4.tscn"],
	["2-1.tscn", "2-2.tscn", "2-3.tscn", "2-4.tscn"],
	["3-1.tscn", "3-2.tscn"],
	["4-1.tscn"]
]

func _ready():
	var root = get_tree().get_root()
	TheScene = root.get_child(root.get_child_count() - 1)
	ThePlayer = TheScene.get_node("Player")
	
func reset_player(should_progress):
	print("reset", ThePlayer.position, ThePlayer.start_pos)
	ThePlayer.position = ThePlayer.start_pos
	ThePlayer.velocity.x = 0
	
