extends Control

signal msgupdater

var current_message = "Hello, can you hear me? Can you hear the VOID?"
var parsed_message = ""
var should_parse = false
var player_input = true

var dialog = null
var tree_index = 0
var dial_index = 0
var dialog_tree = [
	[
		["SET", "Red is one of the 3 additive primary colors. From apples to cardinals to red blood cells, it permeates all around us."],
		["PROMPT", true],
		["SET", "The trees that provide us with oxygen, the vegetables we consume: Green."],
		["PROMPT", true],
		["SET", "The final primary color, additively: Blue."],
		["DELAY", 0.25],
		["ADD", " The water we drink."],
		["DELAY", 0.25],
		["ADD", " It is essential to our very exisence."],
		["PROMPT", true],
	],
]

func _ready():
	visible = false
	_on_animation_player_animation_finished("Appear")
	
func validate_state():
	var s = parsed_message.to_lower()
	if s.contains("red"):
		if s.contains("green"):
			if s.contains("blue"):
				Global.State = Global.REDGREENBLUE
				return
			Global.State = Global.REDGREEN
			return
		if s.contains("blue"):
			Global.State = Global.REDBLUE
			return
		Global.State = Global.RED
		return
	if s.contains("green"):
		if s.contains("blue"):
			Global.State = Global.GREENBLUE
			return
		Global.State = Global.GREEN
		return
	if s.contains("blue"):
		Global.State = Global.BLUE
		return
	Global.State = Global.NONE

func _process(delta):
	if should_parse:
		parsed_message += current_message[parsed_message.length()]
		if current_message.match(parsed_message): pause(1)
		$RichTextLabel.text = parsed_message.replace("Red", "[color=red]Red[/color]").replace("Green", "[color=green]Green[/color]").replace("Blue", "[color=blue]Blue[/color]")
		validate_state()
		
	if Input.is_action_just_pressed("enter") and not player_input:
		player_input = true
		if visible: pause(.1)
		else: begin_dialog()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if self.visible and dial_index < dialog_tree[tree_index].size():
		should_parse = true
		dialog = dialog_tree[tree_index][dial_index]
		if dialog[0] == "DELAY":
			pause(dialog[1])
			return
		elif dialog[0] == "PROMPT":
			should_parse = false
			player_input = false
		elif dialog[0] == "SET":
			set_message(dialog[1])
		elif dialog[0] == "ADD":
			add_to_message(dialog[1])
	elif self.visible:
		end_dialog()
	elif not self.visible:
		player_input = false
		$RichTextLabel.text = ""

func begin_dialog():
	$AnimationPlayer.play("Appear")
	dial_index = 0
	
func end_dialog():
	$AnimationPlayer.play_backwards("Appear")
	should_parse = false
	Global.State = Global.NONE
	
func set_message(text):
	current_message = text
	parsed_message = ""

func add_to_message(text):
	current_message += text
	
func pause(time):
	$Timer.start(time)
	should_parse = false

func _on_timer_timeout() -> void:
	dial_index += 1
	_on_animation_player_animation_finished("Appear")
