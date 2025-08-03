extends Node

var ThePlayer = null
var TheScene = null

enum {RED, GREEN, BLUE, REDGREEN, GREENBLUE, REDBLUE, REDGREENBLUE, NONE}
var State = NONE
var ActiveColors = {"RED":[RED, REDGREEN, REDBLUE, REDGREENBLUE], "GREEN":[GREEN, REDGREEN, GREENBLUE, REDGREENBLUE], "BLUE":[BLUE, GREENBLUE, REDBLUE, REDGREENBLUE]}

var level = 0
var sublevel = 0

var levels = [
	["1_1.tscn", "1_2.tscn", "1_3.tscn", "1_4.tscn"],
	["2_1.tscn", "2_2.tscn", "2_3.tscn", "2_4.tscn"],
	["3_1.tscn", "3_2.tscn"],
	["4_1.tscn"]
]

func _ready():
	var root = get_tree().get_root()
	TheScene = root.get_child(root.get_child_count() - 1)
	ThePlayer = TheScene.get_node("Player")
	#reset_player(false)
	
	var next_level = levels[level][sublevel]
	TheScene.get_node("DialogueBox").tree_index = level
		
	TheScene.get_node("Level").get_child(0).free()
	next_level = load("res://Nodes/Levels/" + next_level)
	TheScene.get_node("Level").add_child(next_level.instantiate())
	
func reset_player(should_progress):
	ThePlayer.position = ThePlayer.start_pos
	ThePlayer.velocity.x = 0
	
	if should_progress:
		if sublevel + 1 == levels[level].size():
			if level + 1 == levels.size(): 
				#end the game
				level = -1
			sublevel = -1
			level += 1
			TheScene.get_node("DialogueBox").tree_index += 1
		sublevel += 1
		
		var next_level = levels[level][sublevel]
		
		TheScene.get_node("Level").get_child(0).free()
		next_level = load("res://Nodes/Levels/" + next_level)
		TheScene.get_node("Level").add_child(next_level.instantiate())
		
		
	
